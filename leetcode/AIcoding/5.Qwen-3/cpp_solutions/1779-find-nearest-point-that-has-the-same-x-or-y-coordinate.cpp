#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int nearestValidPoint(int x, int y, vector<vector<int>>& points) {
        int minDist = INT_MAX;
        int resultIndex = -1;
        for (int i = 0; i < points.size(); ++i) {
            int px = points[i][0];
            int py = points[i][1];
            if (px == x || py == y) {
                int dist = abs(px - x) + abs(py - y);
                if (dist < minDist) {
                    minDist = dist;
                    resultIndex = i;
                }
            }
        }
        return resultIndex;
    }
};