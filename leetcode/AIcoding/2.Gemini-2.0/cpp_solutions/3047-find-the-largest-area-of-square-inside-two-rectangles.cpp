#include <algorithm>

using namespace std;

class Solution {
public:
    int largestSquareArea(vector<vector<int>>& rectangles) {
        int n = rectangles.size();
        int maxArea = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int x1 = max(rectangles[i][0], rectangles[j][0]);
                int y1 = max(rectangles[i][1], rectangles[j][1]);
                int x2 = min(rectangles[i][2], rectangles[j][2]);
                int y2 = min(rectangles[i][3], rectangles[j][3]);

                if (x1 < x2 && y1 < y2) {
                    int side = min(x2 - x1, y2 - y1);
                    maxArea = max(maxArea, side * side);
                }
            }
        }
        return maxArea;
    }
};