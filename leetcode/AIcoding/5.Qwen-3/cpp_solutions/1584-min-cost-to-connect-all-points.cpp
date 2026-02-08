#include <iostream>
#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    int minCostConnectPoints(vector<vector<int>>& points) {
        int n = points.size();
        vector<bool> visited(n, false);
        vector<int> minDist(n, INT_MAX);
        minDist[0] = 0;
        int result = 0;

        for (int i = 0; i < n; ++i) {
            int minIndex = -1;
            int minVal = INT_MAX;
            for (int j = 0; j < n; ++j) {
                if (!visited[j] && minDist[j] < minVal) {
                    minVal = minDist[j];
                    minIndex = j;
                }
            }
            if (minIndex == -1) break;
            visited[minIndex] = true;
            result += minVal;
            for (int j = 0; j < n; ++j) {
                if (!visited[j]) {
                    int dist = abs(points[minIndex][0] - points[j][0]) + abs(points[minIndex][1] - points[j][1]);
                    if (dist < minDist[j]) {
                        minDist[j] = dist;
                    }
                }
            }
        }

        return result;
    }
};