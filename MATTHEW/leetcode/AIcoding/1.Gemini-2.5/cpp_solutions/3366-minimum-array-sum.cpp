#include <vector>
#include <algorithm>

class Solution {
public:
    long long minimumArraySum(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        long long min_sum = 0;
        long long expected_val = 0;

        for (int num : nums) {
            if (num < expected_val) {
                min_sum += expected_val;
                expected_val++;
            } else {
                min_sum += num;
                expected_val = num + 1;
            }
        }

        return min_sum;
    }
};