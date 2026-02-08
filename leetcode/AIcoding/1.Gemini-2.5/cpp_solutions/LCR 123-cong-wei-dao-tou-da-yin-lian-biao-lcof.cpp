#include <vector>
#include <algorithm>

class Solution {
public:
    void arrangeBooks(std::vector<int>& heights) {
        std::sort(heights.begin(), heights.end());
    }
};