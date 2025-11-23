#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int shortestPathWithObstacles(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> visited(m, vector<int>(n, -1));

        queue<vector<int>> q;
        q.push({0, 0, k});
        visited[0][0] = k;

        int steps = 0;

        int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                vector<int> curr = q.front();
                q.pop();
                int x = curr[0];
                int y = curr[1];
                int rem = curr[2];

                if (x == m - 1 && y == n - 1) {
                    return steps;
                }

                for (int d = 0; d < 4; d++) {
                    int nx = x + directions[d][0];
                    int ny = y + directions[d][1];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                        int new_rem = rem;
                        if (grid[nx][ny] == 1) {
                            new_rem--;
                        }

                        if (new_rem >= 0 && visited[nx][ny] < new_rem) {
                            visited[nx][ny] = new_rem;
                            q.push({nx, ny, new_rem});
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};