#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numStamping(const vector<vector<char>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> visited(m, vector<int>(n, 0));
        queue<pair<int, int>> q;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '0') {
                    q.push({i, j});
                    visited[i][j] = 1;
                }
            }
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int k = 0; k < size; ++k) {
                auto [i, j] = q.front();
                q.pop();

                for (int d = 0; d < 4; ++d) {
                    int ni = i + dirs[d][0];
                    int nj = j + dirs[d][1];

                    if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj] && grid[ni][nj] == '0') {
                        visited[ni][nj] = 1;
                        q.push({ni, nj});
                    }
                }
            }
            ++steps;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '1' && !visited[i][j]) {
                    return -1;
                }
            }
        }

        return steps;
    }
};