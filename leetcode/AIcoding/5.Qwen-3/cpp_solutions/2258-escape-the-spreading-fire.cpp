#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maximumMinutes(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> fireTime(m, vector<int>(n, -1));
        queue<pair<int, int>> q;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    fireTime[i][j] = 0;
                }
            }
        }

        int dx[] = {-1, 0, 1, 0};
        int dy[] = {0, 1, 0, -1};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && fireTime[nx][ny] == -1) {
                    fireTime[nx][ny] = fireTime[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        int personTime = -1;
        vector<vector<int>> personVisited(m, vector<int>(n, -1));
        queue<pair<int, int>> personQ;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 2) {
                    personQ.push({i, j});
                    personVisited[i][j] = 0;
                }
            }
        }

        while (!personQ.empty()) {
            auto [x, y] = personQ.front();
            personQ.pop();
            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != 1 && personVisited[nx][ny] == -1) {
                    personVisited[nx][ny] = personVisited[x][y] + 1;
                    personQ.push({nx, ny});
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0 && personVisited[i][j] != -1) {
                    if (fireTime[i][j] == -1) {
                        return 1000000;
                    } else if (personVisited[i][j] < fireTime[i][j]) {
                        personTime = max(personTime, personVisited[i][j]);
                    } else if (personVisited[i][j] == fireTime[i][j]) {
                        bool isLast = true;
                        for (int k = 0; k < 4; ++k) {
                            int nx = i + dx[k];
                            int ny = j + dy[k];
                            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && personVisited[nx][ny] == -1) {
                                isLast = false;
                                break;
                            }
                        }
                        if (isLast) {
                            personTime = max(personTime, personVisited[i][j]);
                        }
                    }
                }
            }
        }

        return personTime;
    }
};