#include <vector>
#include <algorithm>

class Solution {
public:
    int heightChecker(std::vector<int>& heights) {
        std::vector<int> sortedHeights = heights;
        std::sort(sortedHeights.begin(), sortedHeights.end());
        int count = 0;
        for (int i = 0; i < heights.size(); ++i) {
            if (heights[i] != sortedHeights[i]) {
                count++;
            }
        }
        return count;
    }
};