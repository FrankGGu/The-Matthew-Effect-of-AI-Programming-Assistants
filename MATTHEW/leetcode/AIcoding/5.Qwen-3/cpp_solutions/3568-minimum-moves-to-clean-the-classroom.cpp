#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    int minMovesToCleanTheClassroom(vector<vector<char>>& classroom) {
        int rows = classroom.size();
        int cols = classroom[0].size();
        vector<vector<int>> dist(rows, vector<int>(cols, -1));
        queue<pair<int, int>> q;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (classroom[i][j] == 'M') {
                    q.push({i, j});
                    dist[i][j] = 0;
                }
            }
        }

        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (auto& dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        int maxDist = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (classroom[i][j] != 'M' && dist[i][j] != -1) {
                    maxDist = max(maxDist, dist[i][j]);
                }
            }
        }

        return maxDist;
    }
};