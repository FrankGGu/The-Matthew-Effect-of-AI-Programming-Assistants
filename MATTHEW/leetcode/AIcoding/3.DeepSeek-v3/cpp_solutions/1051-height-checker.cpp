
class Solution {
public:
    int heightChecker(std::vector<int>& heights) {
        std::vector<int> sorted = heights;
        std::sort(sorted.begin(), sorted.end());
        int count = 0;
        for (int i = 0; i < heights.size(); ++i) {
            if (heights[i] != sorted[i]) {
                ++count;
            }
        }
        return count;
    }
};