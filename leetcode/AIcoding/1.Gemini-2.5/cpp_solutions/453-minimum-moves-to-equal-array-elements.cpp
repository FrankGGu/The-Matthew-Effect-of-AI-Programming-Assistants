#include <vector>
#include <numeric>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minMoves(std::vector<int>& nums) {
        long long sum = 0;
        int min_val = std::numeric_limits<int>::max();
        for (int num : nums) {
            sum += num;
            min_val = std::min(min_val, num);
        }
        return sum - (long long)nums.size() * min_val;
    }
};