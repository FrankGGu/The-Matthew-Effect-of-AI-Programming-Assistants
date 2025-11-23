#include <vector>
#include <string>
#include <queue>
#include <set>
#include <algorithm>

class Solution {
public:
    int slidingPuzzle(std::vector<std::vector<int>>& board) {
        std::string target = "123450";
        std::string initial_state = "";
        for (int i = 0; i < 2; ++i) {
            for (int j = 0; j < 3; ++j) {
                initial_state += std::to_string(board[i][j]);
            }
        }

        if (initial_state == target) {
            return 0;
        }

        std::queue<std::pair<std::string, int>> q;
        std::set<std::string> visited;

        q.push({initial_state, 0});
        visited.insert(initial_state);

        // Adjacency list for 1D indices (0-5) representing the 2x3 board
        // 0 1 2
        // 3 4 5
        std::vector<std::vector<int>> adj = {
            {1, 3},     // 0 can swap with 1, 3
            {0, 2, 4},  // 1 can swap with 0, 2, 4
            {1, 5},     // 2 can swap with 1, 5
            {0, 4},     // 3 can swap with 0, 4
            {1, 3, 5},  // 4 can swap with 1, 3, 5
            {2, 4}      // 5 can swap with 2, 4
        };

        while (!q.empty()) {
            std::string current_state = q.front().first;
            int moves = q.front().second;
            q.pop();

            int zero_pos = current_state.find('0');

            for (int next_zero_pos : adj[zero_pos]) {
                std::string next_state = current_state;
                std::swap(next_state[zero_pos], next_state[next_zero_pos]);

                if (next_state == target) {
                    return moves + 1;
                }

                if (visited.find(next_state) == visited.end()) {
                    visited.insert(next_state);
                    q.push({next_state, moves + 1});
                }
            }
        }

        return -1; // Target not reachable
    }
};