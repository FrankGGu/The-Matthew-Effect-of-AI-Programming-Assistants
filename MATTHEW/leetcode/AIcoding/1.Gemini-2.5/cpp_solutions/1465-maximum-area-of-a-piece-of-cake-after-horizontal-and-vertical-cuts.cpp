#include <vector>
#include <algorithm>

class Solution {
public:
    int maxArea(int h, int w, std::vector<int>& horizontalCuts, std::vector<int>& verticalCuts) {
        const int MOD = 1e9 + 7;

        std::sort(horizontalCuts.begin(), horizontalCuts.end());
        std::sort(verticalCuts.begin(), verticalCuts.end());

        long long max_h = horizontalCuts[0];
        for (size_t i = 1; i < horizontalCuts.size(); ++i) {
            max_h = std::max(max_h, (long long)horizontalCuts[i] - horizontalCuts[i - 1]);
        }
        max_h = std::max(max_h, (long long)h - horizontalCuts.back());

        long long max_w = verticalCuts[0];
        for (size_t i = 1; i < verticalCuts.size(); ++i) {
            max_w = std::max(max_w, (long long)verticalCuts[i] - verticalCuts[i - 1]);
        }
        max_w = std::max(max_w, (long long)w - verticalCuts.back());

        return (max_h * max_w) % MOD;
    }
};