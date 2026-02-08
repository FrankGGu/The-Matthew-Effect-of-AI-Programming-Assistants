#include <vector>
#include <numeric>
#include <map>
#include <utility>

class Solution {
public:
    long long interchangeableRectangles(std::vector<std::vector<int>>& rectangles) {
        std::map<std::pair<int, int>, int> ratio_counts;
        long long count = 0;

        for (const auto& rect : rectangles) {
            int w = rect[0];
            int h = rect[1];
            int common_divisor = std::gcd(w, h);
            std::pair<int, int> ratio = {w / common_divisor, h / common_divisor};

            count += ratio_counts[ratio];
            ratio_counts[ratio]++;
        }

        return count;
    }
};