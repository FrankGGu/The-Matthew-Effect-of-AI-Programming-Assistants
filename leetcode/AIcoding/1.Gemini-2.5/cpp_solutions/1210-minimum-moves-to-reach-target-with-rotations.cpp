#include <vector>
#include <queue>
#include <set>
#include <tuple>

class Solution {
public:
    int minimumMoves(std::vector<std::vector<int>>& grid) {
        int N = grid.size();

        std::queue<std::tuple<int, int, bool, int>> q;
        std::set<std::tuple<int, int, bool>> visited;

        auto is_valid_cell = [&](int r, int c) {
            return r >= 0 && r < N && c >= 0 && c < N && grid[r][c] == 0;
        };

        q.push({0, 0, true, 0});
        visited.insert({0, 0, true});

        while (!q.empty()) {
            auto [r, c, is_horizontal, steps] = q.front();
            q.pop();

            if (r == N - 1 && c == N - 2 && is_horizontal) {
                return steps;
            }

            // Move Right
            if (is_horizontal) {
                if (is_valid_cell(r, c + 2)) {
                    if (visited.find({r, c + 1, true}) == visited.end()) {
                        visited.insert({r, c + 1, true});
                        q.push({r, c + 1, true, steps + 1});
                    }
                }
            } else {
                if (is_valid_cell(r, c + 1) && is_valid_cell(r + 1, c + 1)) {
                    if (visited.find({r, c + 1, false}) == visited.end()) {
                        visited.insert({r, c + 1, false});
                        q.push({r, c + 1, false, steps + 1});
                    }
                }
            }

            // Move Down
            if (is_horizontal) {
                if (is_valid_cell(r + 1, c) && is_valid_cell(r + 1, c + 1)) {
                    if (visited.find({r + 1, c, true}) == visited.end()) {
                        visited.insert({r + 1, c, true});
                        q.push({r + 1, c, true, steps + 1});
                    }
                }
            } else {
                if (is_valid_cell(r + 2, c)) {
                    if (visited.find({r + 1, c, false}) == visited.end()) {
                        visited.insert({r + 1, c, false});
                        q.push({r + 1, c, false, steps + 1});
                    }
                }
            }

            // Rotate Clockwise (Horizontal to Vertical)
            if (is_horizontal) {
                if (is_valid_cell(r + 1, c) && is_valid_cell(r + 1, c + 1)) {
                    if (visited.find({r, c, false}) == visited.end()) {
                        visited.insert({r, c, false});
                        q.push({r, c, false, steps + 1});
                    }
                }
            }

            // Rotate Counter-clockwise (Vertical to Horizontal)
            if (!is_horizontal) {
                if (is_valid_cell(r, c + 1) && is_valid_cell(r + 1, c + 1)) {
                    if (visited.find({r, c, true}) == visited.end()) {
                        visited.insert({r, c, true});
                        q.push({r, c, true, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
};