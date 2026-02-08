#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <utility>
#include <algorithm>

using namespace std;

class Solution {
public:
    int containVirus(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int res = 0;

        while (true) {
            vector<vector<int>> visited(rows, vector<int>(cols, 0));
            vector<pair<int, int>> infectionSites;
            vector<vector<int>> boundaries;
            vector<int> boundarySizes;

            for (int i = 0; i < rows; ++i) {
                for (int j = 0; j < cols; ++j) {
                    if (grid[i][j] == 1 && visited[i][j] == 0) {
                        queue<pair<int, int>> q;
                        q.push({i, j});
                        visited[i][j] = 1;
                        vector<pair<int, int>> currentBoundary;
                        vector<pair<int, int>> currentInfection;
                        currentInfection.push_back({i, j});

                        while (!q.empty()) {
                            auto [x, y] = q.front();
                            q.pop();

                            for (int dx = -1; dx <= 1; ++dx) {
                                for (int dy = -1; dy <= 1; ++dy) {
                                    if (abs(dx) + abs(dy) != 1) continue;
                                    int nx = x + dx;
                                    int ny = y + dy;

                                    if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                                        if (grid[nx][ny] == 1 && visited[nx][ny] == 0) {
                                            visited[nx][ny] = 1;
                                            q.push({nx, ny});
                                            currentInfection.push_back({nx, ny});
                                        } else if (grid[nx][ny] == 0) {
                                            currentBoundary.push_back({nx, ny});
                                        }
                                    }
                                }
                            }
                        }

                        if (!currentInfection.empty()) {
                            infectionSites.push_back(currentInfection[0]);
                            boundaries.push_back(currentBoundary);
                            boundarySizes.push_back(currentBoundary.size());
                        }
                    }
                }
            }

            if (infectionSites.empty()) break;

            int maxIndex = 0;
            for (int i = 1; i < boundarySizes.size(); ++i) {
                if (boundarySizes[i] > boundarySizes[maxIndex]) {
                    maxIndex = i;
                }
            }

            int total = 0;
            for (int i = 0; i < boundaries.size(); ++i) {
                if (i == maxIndex) {
                    for (auto [x, y] : boundaries[i]) {
                        grid[x][y] = 2;
                    }
                    total += boundaries[i].size();
                } else {
                    for (auto [x, y] : boundaries[i]) {
                        grid[x][y] = 1;
                    }
                }
            }

            res += total;
        }

        return res;
    }
};