#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int areaOfMaxDiagonal(vector<vector<int>>& rectangles) {
        int maxArea = 0;
        for (const auto& rect : rectangles) {
            int x = rect[0];
            int y = rect[1];
            int diagonal = x * x + y * y;
            if (diagonal > maxArea) {
                maxArea = diagonal;
            }
        }
        int result = 0;
        for (const auto& rect : rectangles) {
            int x = rect[0];
            int y = rect[1];
            int diagonal = x * x + y * y;
            if (diagonal == maxArea) {
                result = max(result, x * y);
            }
        }
        return result;
    }
};