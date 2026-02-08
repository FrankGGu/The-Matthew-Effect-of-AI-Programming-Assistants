#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    std::vector<long long> findPrefixScore(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<long long> result(n);

        long long current_max = 0;
        long long current_prefix_score_sum = 0;

        for (int i = 0; i < n; ++i) {
            current_max = std::max(current_max, (long long)nums[i]);
            current_prefix_score_sum += (nums[i] + current_max);
            result[i] = current_prefix_score_sum;
        }

        return result;
    }
};