#include <vector>
#include <string>
#include <set>
#include <utility> // For std::pair
#include <tuple>   // For std::tuple

class Solution {
private:
    std::vector<std::tuple<char, int, int>> pieces_info; // Stores (type, row, col) for each piece
    std::vector<std::vector<std::pair<int, int>>> all_possible_moves; // Stores all possible destination squares for each piece
    int N; // Number of pieces
    int total_valid_combinations; // Counter for valid combinations

    // Helper to check if a square (r, c) is within the 8x8 board boundaries
    bool isValid(int r, int c) {
        return r >= 0 && r < 8 && c >= 0 && c < 8;
    }

    // Generates all possible destination squares for a single piece
    // A piece must move to a different square, so the starting square is not included.
    // This function does not consider other pieces on the board.
    std::vector<std::pair<int, int>> getMoves(char type, int r, int c) {
        std::vector<std::pair<int, int>> moves;

        // Rook movement directions: horizontal and vertical
        int rook_dr[] = {0, 0, 1, -1};
        int rook_dc[] = {1, -1, 0, 0};
        if (type == 'R' || type == 'Q') {
            for (int i = 0; i < 4; ++i) {
                int cur_r = r + rook_dr[i];
                int cur_c = c + rook_dc[i];
                while (isValid(cur_r, cur_c)) {
                    moves.push_back({cur_r, cur_c});
                    cur_r += rook_dr[i];
                    cur_c += rook_dc[i];
                }
            }
        }

        // Bishop movement directions: diagonals
        int bishop_dr[] = {1, 1, -1, -1};
        int bishop_dc[] = {1, -1, 1, -1};
        if (type == 'B' || type == 'Q') {
            for (int i = 0; i < 4; ++i) {
                int cur_r = r + bishop_dr[i];
                int cur_c = c + bishop_dc[i];
                while (isValid(cur_r, cur_c)) {
                    moves.push_back({cur_r, cur_c});
                    cur_r += bishop_dr[i];
                    cur_c += bishop_dc[i];
                }
            }
        }
        return moves;
    }

    // Generates the set of squares on the path between (r1, c1) and (r2, c2),
    // EXCLUDING the start (r1, c1) and end (r2, c2) squares.
    // Assumes (r1, c1) and (r2, c2) are distinct and on the same straight line (rook/bishop/queen move).
    std::set<std::pair<int, int>> get_path_squares_intermediate(int r1, int c1, int r2, int c2) {
        std::set<std::pair<int, int>> path;
        // If start and end are the same, there are no intermediate squares.
        // This case should not be reached due to problem constraints ("moves to a different square").
        if (r1 == r2 && c1 == c2) return path;

        int dr = 0, dc = 0;
        if (r1 < r2) dr = 1;
        else if (r1 > r2) dr = -1;
        if (c1 < c2) dc = 1;
        else if (c1 > c2) dc = -1;

        int cur_r = r1 + dr;
        int cur_c = c1 + dc;

        // Iterate from the square after start until the square before end
        while (cur_r != r2 || cur_c != c2) {
            path.insert({cur_r, cur_c});
            cur_r += dr;
            cur_c += dc;
        }
        return path;
    }

    // Recursive backtracking function to generate and validate move combinations
    // k: The index of the current piece being considered (0 to N-1)
    // current_destinations: A vector storing the chosen destination squares for pieces 0 to k-1
    void solve(int k, std::vector<std::pair<int, int>>& current_destinations) {
        // Base case: All N pieces have been assigned a destination square
        if (k == N) {
            // Validate the current combination of moves

            // 1. Check if all destination squares are distinct
            std::set<std::pair<int, int>> final_positions_set;
            for (const auto& dest : current_destinations) {
                final_positions_set.insert(dest);
            }
            if (final_positions_set.size() != N) {
                return; // Not all destination squares are unique
            }

            // 2. Check for path collisions
            // Create a set of all initial positions for quick lookup
            std::set<std::pair<int, int>> initial_positions_set;
            for (int i = 0; i < N; ++i) {
                initial_positions_set.insert({std::get<1>(pieces_info[i]), std::get<2>(pieces_info[i])});
            }

            // For each piece's move, check its intermediate path for collisions
            for (int i = 0; i < N; ++i) {
                int s_r = std::get<1>(pieces_info[i]); // Start row of piece i
                int s_c = std::get<2>(pieces_info[i]); // Start column of piece i
                int e_r = current_destinations[i].first;  // End row of piece i
                int e_c = current_destinations[i].second; // End column of piece i

                // Get all intermediate squares on the path of piece i
                std::set<std::pair<int, int>> intermediate_path_i = get_path_squares_intermediate(s_r, s_c, e_r, e_c);

                // Check if any intermediate square on piece i's path is occupied by
                // another piece's starting position or destination position.
                for (const auto& sq : intermediate_path_i) {
                    if (initial_positions_set.count(sq) || final_positions_set.count(sq)) {
                        return; // Collision detected
                    }
                }
            }

            // If all checks pass, this is a valid combination
            total_valid_combinations++;
            return;
        }

        // Recursive step: Try each possible move for the current piece (k)
        for (const auto& possible_move : all_possible_moves[k]) {
            current_destinations.push_back(possible_move); // Add the chosen move
            solve(k + 1, current_destinations);             // Recurse for the next piece
            current_destinations.pop_back();                // Backtrack: remove the move for current piece
        }
    }

public:
    int countCombinations(std::vector<std::string>& pieces, std::vector<std::vector<int>>& positions) {
        N = pieces.size();

        // Clear and initialize member variables for each test case
        pieces_info.clear();
        all_possible_moves.clear();
        total_valid_combinations = 0;

        // Parse input and store piece information
        for (int i = 0; i < N; ++i) {
            char type = pieces[i][0];
            int r = positions[i][0] - 1; // Convert to 0-indexed (1-8 to 0-7)
            int c = positions[i][1] - 1; // Convert to 0-indexed
            pieces_info.emplace_back(type, r, c);
        }

        // Pre-generate all possible moves for each piece (without considering other pieces)
        all_possible_moves.resize(N);
        for (int i = 0; i < N; ++i) {
            char type = std::get<0>(pieces_info[i]);
            int r = std::get<1>(pieces_info[i]);
            int c = std::get<2>(pieces_info[i]);
            all_possible_moves[i] = getMoves(type, r, c);
        }

        // Start the recursive backtracking process
        std::vector<std::pair<int, int>> current_destinations;
        solve(0, current_destinations);

        return total_valid_combinations;
    }
};