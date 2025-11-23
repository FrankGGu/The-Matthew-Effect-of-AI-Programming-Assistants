#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    long long minNumberOperations(std::vector<int>& target) {
        if (target.empty()) {
            return 0;
        }

        long long operations = 0;
        long long prev_val = 0;

        for (int val : target) {
            operations += std::max(0LL, val - prev_val);
            prev_val = val;
        }

        return operations;
    }
};