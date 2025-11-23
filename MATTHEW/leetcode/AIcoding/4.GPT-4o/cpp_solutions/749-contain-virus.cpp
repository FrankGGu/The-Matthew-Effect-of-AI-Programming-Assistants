class Solution {
public:
    int containVirus(vector<vector<int>>& isInfected) {
        int totalWalls = 0;
        while (true) {
            vector<vector<int>> visited(isInfected.size(), vector<int>(isInfected[0].size(), 0));
            vector<int> walls, regions;
            vector<pair<int, int>> boundaries;
            int regionCount = 0;

            for (int i = 0; i < isInfected.size(); i++) {
                for (int j = 0; j < isInfected[0].size(); j++) {
                    if (isInfected[i][j] == 1 && !visited[i][j]) {
                        regionCount++;
                        int wallCount = 0;
                        vector<pair<int, int>> regionBoundary;
                        queue<pair<int, int>> q;
                        q.push({i, j});
                        visited[i][j] = 1;

                        while (!q.empty()) {
                            auto [x, y] = q.front(); q.pop();
                            for (auto [dx, dy] : vector<pair<int, int>>{{0,1}, {1,0}, {0,-1}, {-1,0}}) {
                                int nx = x + dx, ny = y + dy;
                                if (nx >= 0 && nx < isInfected.size() && ny >= 0 && ny < isInfected[0].size()) {
                                    if (isInfected[nx][ny] == 1 && !visited[nx][ny]) {
                                        visited[nx][ny] = 1;
                                        q.push({nx, ny});
                                    } else if (isInfected[nx][ny] == 0) {
                                        wallCount++;
                                    } else if (isInfected[nx][ny] == -1) {
                                        regionBoundary.push_back({nx, ny});
                                    }
                                }
                            }
                        }
                        walls.push_back(wallCount);
                        boundaries.push_back(regionBoundary);
                        regions.push_back(regionCount);
                    }
                }
            }

            if (regions.empty()) break;

            int maxRegionIndex = max_element(walls.begin(), walls.end()) - walls.begin();
            totalWalls += walls[maxRegionIndex];
            for (int i = 0; i < regions.size(); i++) {
                if (i == maxRegionIndex) {
                    for (auto [x, y] : boundaries[i]) {
                        isInfected[x][y] = -1;
                    }
                } else {
                    for (auto [x, y] : boundaries[i]) {
                        isInfected[x][y] = 1;
                    }
                }
            }
        }
        return totalWalls;
    }
};