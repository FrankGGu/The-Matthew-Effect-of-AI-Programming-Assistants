#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    double triangleArea(vector<int>& point1, vector<int>& point2, vector<int>& point3) {
        return 0.5 * abs(
            (point2[0] - point1[0]) * (point3[1] - point1[1]) -
            (point2[1] - point1[1]) * (point3[0] - point1[0])
        );
    }

    double largestTriangleArea(vector<vector<int>>& points) {
        double maxArea = 0;
        for (int i = 0; i < 4; ++i) {
            for (int j = i + 1; j < 5; ++j) {
                for (int k = j + 1; k < 6; ++k) {
                    maxArea = max(maxArea, triangleArea(points[i], points[j], points[k]));
                }
            }
        }
        return maxArea;
    }
};