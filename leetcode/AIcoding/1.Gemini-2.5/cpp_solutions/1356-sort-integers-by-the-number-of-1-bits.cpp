#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortByBits(std::vector<int>& arr) {
        std::sort(arr.begin(), arr.end(), [](int a, int b) {
            int count1_a = __builtin_popcount(a);
            int count1_b = __builtin_popcount(b);

            if (count1_a != count1_b) {
                return count1_a < count1_b;
            } else {
                return a < b;
            }
        });
        return arr;
    }
};