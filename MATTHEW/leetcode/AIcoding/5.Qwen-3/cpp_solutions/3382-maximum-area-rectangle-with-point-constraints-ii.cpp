#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxArea(vector<vector<int>>& points) {
        if (points.size() < 4) return 0;

        sort(points.begin(), points.end());

        vector<vector<int>> uniquePoints;
        for (int i = 0; i < points.size(); ++i) {
            if (i == 0 || points[i] != points[i - 1]) {
                uniquePoints.push_back(points[i]);
            }
        }

        points = uniquePoints;

        int n = points.size();
        int maxArea = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int dx = points[j][0] - points[i][0];
                int dy = points[j][1] - points[i][1];
                int area = dx * dy;
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }

        return maxArea;
    }
};