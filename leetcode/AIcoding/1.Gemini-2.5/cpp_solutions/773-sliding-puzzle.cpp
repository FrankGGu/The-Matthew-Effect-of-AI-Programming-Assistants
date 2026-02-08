#include <vector>
#include <string>
#include <queue>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int slidingPuzzle(std::vector<std::vector<int>>& board) {
        std::string target = "123450";
        std::string start = "";
        for (int i = 0; i < 2; ++i) {
            for (int j = 0; j < 3; ++j) {
                start += std::to_string(board[i][j]);
            }
        }

        if (start == target) {
            return 0;
        }

        std::queue<std::string> q;
        std::unordered_set<std::string> visited;
        std::vector<std::vector<int>> neighbors = {
            {1, 3}, {0, 2, 4}, {1, 5},
            {0, 4}, {1, 3, 5}, {2, 4}
        };

        q.push(start);
        visited.insert(start);
        int moves = 0;

        while (!q.empty()) {
            int level_size = q.size();
            for (int i = 0; i < level_size; ++i) {
                std::string current_state = q.front();
                q.pop();

                if (current_state == target) {
                    return moves;
                }

                int zero_pos = current_state.find('0');

                for (int neighbor_idx : neighbors[zero_pos]) {
                    std::string next_state = current_state;
                    std::swap(next_state[zero_pos], next_state[neighbor_idx]);
                    if (visited.find(next_state) == visited.end()) {
                        visited.insert(next_state);
                        q.push(next_state);
                    }
                }
            }
            moves++;
        }

        return -1;
    }
};