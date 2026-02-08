#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cutOffTree(vector<vector<int>>& forest) {
        if (forest.empty() || forest[0].empty()) {
            return 0;
        }

        int m = forest.size();
        int n = forest[0].size();

        vector<tuple<int, int, int>> trees;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (forest[i][j] > 1) {
                    trees.emplace_back(forest[i][j], i, j);
                }
            }
        }

        sort(trees.begin(), trees.end());

        int start_row = 0;
        int start_col = 0;
        int total_steps = 0;

        for (const auto& tree : trees) {
            int target_row = get<1>(tree);
            int target_col = get<2>(tree);

            int steps = bfs(forest, start_row, start_col, target_row, target_col);

            if (steps == -1) {
                return -1;
            }

            total_steps += steps;
            start_row = target_row;
            start_col = target_col;
        }

        return total_steps;
    }

private:
    int bfs(vector<vector<int>>& forest, int start_row, int start_col, int target_row, int target_col) {
        int m = forest.size();
        int n = forest[0].size();

        vector<vector<int>> dist(m, vector<int>(n, -1));
        queue<pair<int, int>> q;

        dist[start_row][start_col] = 0;
        q.push({start_row, start_col});

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            int row = q.front().first;
            int col = q.front().second;
            q.pop();

            if (row == target_row && col == target_col) {
                return dist[row][col];
            }

            for (int i = 0; i < 4; ++i) {
                int new_row = row + dr[i];
                int new_col = col + dc[i];

                if (new_row >= 0 && new_row < m && new_col >= 0 && new_col < n && forest[new_row][new_col] != 0 && dist[new_row][new_col] == -1) {
                    dist[new_row][new_col] = dist[row][col] + 1;
                    q.push({new_row, new_col});
                }
            }
        }

        return -1;
    }
};