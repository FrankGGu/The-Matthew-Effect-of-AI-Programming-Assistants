#include <algorithm> // For std::min
#include <cmath>     // For std::sqrt

class Solution {
public:
    int minOperations(int k) {
        long long min_ops = k - 1;

        for (long long x = 1; x * x <= k; ++x) {
            long long y_val = (k + x - 1) / x;
            long long current_ops = (x - 1) + (y_val - 1) * x;
            min_ops = std::min(min_ops, current_ops);
        }

        return static_cast<int>(min_ops);
    }
};