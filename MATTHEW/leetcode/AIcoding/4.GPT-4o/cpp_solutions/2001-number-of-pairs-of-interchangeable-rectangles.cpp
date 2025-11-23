#include <vector>
#include <unordered_map>

class Solution {
public:
    long long interchangeableRectangles(std::vector<std::vector<int>>& rectangles) {
        std::unordered_map<double, long long> ratioCount;
        long long count = 0;

        for (const auto& rect : rectangles) {
            double ratio = static_cast<double>(rect[0]) / rect[1];
            count += ratioCount[ratio]++;
        }

        return count;
    }
};