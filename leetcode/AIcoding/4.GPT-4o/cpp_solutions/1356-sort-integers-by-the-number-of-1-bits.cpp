#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortByBits(std::vector<int>& arr) {
        auto countBits = [](int x) {
            return __builtin_popcount(x);
        };

        std::sort(arr.begin(), arr.end(), [&](int a, int b) {
            return countBits(a) == countBits(b) ? a < b : countBits(a) < countBits(b);
        });

        return arr;
    }
};