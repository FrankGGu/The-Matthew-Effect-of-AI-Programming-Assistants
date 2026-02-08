#include <vector>
#include <string>
#include <utility> // For std::pair

class Solution {
private:
    int M, N;
    std::vector<std::string> board;

    // Directions for neighbors: up, down, left, right
    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    // Maps to store coordinates and their corresponding indices in the bipartite graph
    std::vector<std::pair<int, int>> white_cells_coords; 
    std::vector<std::pair<int, int>> black_cells_coords; 

    // cell_to_white_idx[r][c] = index in white_cells_coords if (r,c) is white, else -1
    std::vector<std::vector<int>> cell_to_white_idx; 
    // cell_to_black_idx[r][c] = index in black_cells_coords if (r,c) is black, else -1
    std::vector<std::vector<int>> cell_to_black_idx; 

    // For bipartite matching algorithm
    std::vector<int> match;    // match[black_cell_idx] = white_cell_idx, or -1 if unmatched
    std::vector<bool> visited; // visited[white_cell_idx] during a single DFS call

    // Helper to check if (r, c) is within bounds and not a broken cell
    bool is_valid(int r, int c) {
        return r >= 0 && r < M && c >= 0 && c < N && board[r][c] == '.';
    }

    // DFS function to find an augmenting path
    // u_white_idx is the index of a white cell in white_cells_coords
    bool dfs(int u_white_idx) {
        visited[u_white_idx] = true; 

        int r = white_cells_coords[u_white_idx].first;
        int c = white_cells_coords[u_white_idx].second;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (is_valid(nr, nc)) {
                int v_black_idx = cell_to_black_idx[nr][nc];

                if (match[v_black_idx] == -1 || (!visited[match[v_black_idx]] && dfs(match[v_black_idx]))) {
                    match[v_black_idx] = u_white_idx; 
                    return true; 
                }
            }
        }
        return false; 
    }

public:
    int dominoTiling(std::vector<std::string>& b) {
        board = b;
        M = board.size();
        if (M == 0) return 0;
        N = board[0].size();
        if (N == 0) return 0;

        white_cells_coords.clear();
        black_cells_coords.clear();
        cell_to_white_idx.assign(M, std::vector<int>(N, -1));
        cell_to_black_idx.assign(M, std::vector<int>(N, -1));

        for (int r = 0; r < M; ++r) {
            for (int c = 0; c < N; ++c) {
                if (board[r][c] == '.') { 
                    if ((r + c) % 2 == 0) { 
                        cell_to_white_idx[r][c] = white_cells_coords.size();
                        white_cells_coords.push_back({r, c});
                    } else { 
                        cell_to_black_idx[r][c] = black_cells_coords.size();
                        black_cells_coords.push_back({r, c});
                    }
                }
            }
        }

        int num_white_cells = white_cells_coords.size();
        int num_black_cells = black_cells_coords.size();

        match.assign(num_black_cells, -1);

        int max_matching = 0;
        for (int i = 0; i < num_white_cells; ++i) {
            visited.assign(num_white_cells, false); 
            if (dfs(i)) { 
                max_matching++; 
            }
        }

        return max_matching; 
    }
};