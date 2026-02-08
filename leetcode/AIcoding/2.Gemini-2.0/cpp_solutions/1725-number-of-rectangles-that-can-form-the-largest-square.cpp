#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countGoodRectangles(vector<vector<int>>& rectangles) {
        int maxLen = 0;
        int count = 0;
        for (auto& rect : rectangles) {
            int side = min(rect[0], rect[1]);
            if (side > maxLen) {
                maxLen = side;
                count = 1;
            } else if (side == maxLen) {
                count++;
            }
        }
        return count;
    }
};