#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minCostToReachEveryPosition(vector<int>& startPos, vector<int>& homePos, vector<int>& rowCosts, vector<int>& colCosts) {
        int rows = rowCosts.size();
        int cols = colCosts.size();

        vector<vector<int>> dist(rows, vector<int>(cols, INT_MAX));
        priority_queue<pair<int, pair<int, int>>> pq;

        int startRow = startPos[0];
        int startCol = startPos[1];
        dist[startRow][startCol] = 0;
        pq.push({0, {startRow, startCol}});

        int dirX[] = {-1, 1, 0, 0};
        int dirY[] = {0, 0, -1, 1};

        while (!pq.empty()) {
            int cost = -pq.top().first;
            int x = pq.top().second.first;
            int y = pq.top().second.second;
            pq.pop();

            if (cost > dist[x][y]) continue;

            for (int i = 0; i < 4; ++i) {
                int nx = x + dirX[i];
                int ny = y + dirY[i];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                    int newCost = cost + (i < 2 ? rowCosts[nx] : colCosts[ny]);
                    if (newCost < dist[nx][ny]) {
                        dist[nx][ny] = newCost;
                        pq.push({-newCost, {nx, ny}});
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                result += dist[i][j];
            }
        }

        return result;
    }
};