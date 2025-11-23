#include <vector>
#include <queue>
#include <algorithm>
#include <tuple>

class Solution {
public:
    int cutOffTree(std::vector<std::vector<int>>& forest) {
        int m = forest.size();
        if (m == 0) return 0;
        int n = forest[0].size();
        if (n == 0) return 0;

        std::vector<std::tuple<int, int, int>> trees;
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (forest[r][c] > 1) {
                    trees.emplace_back(forest[r][c], r, c);
                }
            }
        }

        std::sort(trees.begin(), trees.end());

        int total_steps = 0;
        int current_r = 0;
        int current_c = 0;

        for (const auto& tree : trees) {
            int target_r = std::get<1>(tree);
            int target_c = std::get<2>(tree);

            int steps = bfs(forest, current_r, current_c, target_r, target_c, m, n);

            if (steps == -1) {
                return -1;
            }

            total_steps += steps;
            current_r = target_r;
            current_c = target_c;
        }

        return total_steps;
    }

private:
    int bfs(const std::vector<std::vector<int>>& forest, int start_r, int start_c, int target_r, int target_c, int m, int n) {
        if (start_r == target_r && start_c == target_c) {
            return 0;
        }

        std::queue<std::pair<int, int>> q;
        q.push({start_r, start_c});

        std::vector<std::vector<bool>> visited(m, std::vector<bool>(n, false));
        visited[start_r][start_c] = true;

        int steps = 0;
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            int level_size = q.size();
            for (int i = 0; i < level_size; ++i) {
                std::pair<int, int> curr = q.front();
                q.pop();

                for (int j = 0; j < 4; ++j) {
                    int next_r = curr.first + dr[j];
                    int next_c = curr.second + dc[j];

                    if (next_r >= 0 && next_r < m && next_c >= 0 && next_c < n &&
                        !visited[next_r][next_c] && forest[next_r][next_c] != 0) {

                        if (next_r == target_r && next_c == target_c) {
                            return steps + 1;
                        }

                        visited[next_r][next_c] = true;
                        q.push({next_r, next_c});
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};