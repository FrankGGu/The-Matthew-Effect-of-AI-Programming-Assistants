#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int trapRainWater(vector<vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) return 0;

        int rows = heightMap.size();
        int cols = heightMap[0].size();

        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> minHeap;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                minHeap.push({heightMap[i][j], {i, j}});
                visited[i][j] = true;
            }
        }

        int result = 0;
        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!minHeap.empty()) {
            auto current = minHeap.top();
            minHeap.pop();
            int height = current.first;
            int x = current.second.first;
            int y = current.second.second;

            for (auto& dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    result += max(0, height - heightMap[nx][ny]);
                    minHeap.push({max(height, heightMap[nx][ny]), {nx, ny}});
                }
            }
        }

        return result;
    }
};