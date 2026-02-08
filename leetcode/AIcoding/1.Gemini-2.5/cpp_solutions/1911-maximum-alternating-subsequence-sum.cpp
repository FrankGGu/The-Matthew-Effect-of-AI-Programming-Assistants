#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long maxAlternatingSum(std::vector<int>& nums) {
        long long max_sum_ending_added = 0;
        long long max_sum_ending_subtracted = LLONG_MIN / 2; 

        for (int num : nums) {
            long long new_max_sum_ending_added = std::max(max_sum_ending_added, std::max(0LL, max_sum_ending_subtracted) + num);
            long long new_max_sum_ending_subtracted = std::max(max_sum_ending_subtracted, max_sum_ending_added - num);

            max_sum_ending_added = new_max_sum_ending_added;
            max_sum_ending_subtracted = new_max_sum_ending_subtracted;
        }

        return max_sum_ending_added;
    }
};