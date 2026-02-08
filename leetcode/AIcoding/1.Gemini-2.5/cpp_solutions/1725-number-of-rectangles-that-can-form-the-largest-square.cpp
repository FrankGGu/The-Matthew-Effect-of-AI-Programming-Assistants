#include <vector>
#include <algorithm>

class Solution {
public:
    int countGoodRectangles(std::vector<std::vector<int>>& rectangles) {
        int max_possible_side = 0;
        for (const auto& rect : rectangles) {
            max_possible_side = std::max(max_possible_side, std::min(rect[0], rect[1]));
        }

        int count = 0;
        for (const auto& rect : rectangles) {
            if (std::min(rect[0], rect[1]) == max_possible_side) {
                count++;
            }
        }
        return count;
    }
};