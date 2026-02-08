#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int containVirus(vector<vector<int>>& isInfected) {
        int n = isInfected.size();
        int m = isInfected[0].size();
        int ans = 0;

        while (true) {
            vector<vector<bool>> visited(n, vector<bool>(m, false));
            vector<vector<pair<int, int>>> regions;
            vector<int> perimeters;
            vector<int> infectedCount;

            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < m; ++j) {
                    if (isInfected[i][j] == 1 && !visited[i][j]) {
                        regions.push_back({});
                        perimeters.push_back(0);
                        infectedCount.push_back(0);
                        queue<pair<int, int>> q;
                        q.push({i, j});
                        visited[i][j] = true;
                        regions.back().push_back({i, j});
                        infectedCount.back()++;

                        while (!q.empty()) {
                            int row = q.front().first;
                            int col = q.front().second;
                            q.pop();

                            int dr[] = {0, 0, 1, -1};
                            int dc[] = {1, -1, 0, 0};

                            for (int k = 0; k < 4; ++k) {
                                int nr = row + dr[k];
                                int nc = col + dc[k];

                                if (nr >= 0 && nr < n && nc >= 0 && nc < m) {
                                    if (isInfected[nr][nc] == 1 && !visited[nr][nc]) {
                                        q.push({nr, nc});
                                        visited[nr][nc] = true;
                                        regions.back().push_back({nr, nc});
                                        infectedCount.back()++;
                                    } else if (isInfected[nr][nc] == 0) {
                                        perimeters.back()++;
                                    }
                                } else {
                                    perimeters.back()++;
                                }
                            }
                        }
                    }
                }
            }

            if (regions.empty()) break;

            int maxInfectedIdx = 0;
            for (int i = 1; i < regions.size(); ++i) {
                if (infectedCount[i] > infectedCount[maxInfectedIdx]) {
                    maxInfectedIdx = i;
                }
            }

            ans += perimeters[maxInfectedIdx];

            for (auto& cell : regions[maxInfectedIdx]) {
                isInfected[cell.first][cell.second] = -1;
            }

            for (int i = 0; i < regions.size(); ++i) {
                if (i != maxInfectedIdx) {
                    vector<vector<bool>> futureInfected(n, vector<bool>(m, false));
                    for (auto& cell : regions[i]) {
                        int row = cell.first;
                        int col = cell.second;

                        int dr[] = {0, 0, 1, -1};
                        int dc[] = {1, -1, 0, 0};

                        for (int k = 0; k < 4; ++k) {
                            int nr = row + dr[k];
                            int nc = col + dc[k];

                            if (nr >= 0 && nr < n && nc >= 0 && nc < m && isInfected[nr][nc] == 0 && !futureInfected[nr][nc]) {
                                isInfected[nr][nc] = 1;
                                futureInfected[nr][nc] = true;
                            }
                        }
                    }
                }
            }

            bool changed = false;
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < m; ++j) {
                    if (isInfected[i][j] == 1) {
                        changed = true;
                        break;
                    }
                }
                if (changed) break;
            }
            if (!changed) break;

            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < m; ++j) {
                    if (isInfected[i][j] == -1) {
                        isInfected[i][j] = 0;
                    }
                }
            }
        }

        return ans;
    }
};