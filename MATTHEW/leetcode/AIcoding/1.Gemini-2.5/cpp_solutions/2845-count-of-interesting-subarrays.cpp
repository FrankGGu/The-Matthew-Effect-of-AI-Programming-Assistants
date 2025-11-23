#include <vector>
#include <numeric>

class Solution {
public:
    long long countInterestingSubarrays(std::vector<int>& nums, int k) {
        long long ans = 0;
        int current_odd_count = 0;

        std::vector<int> remainder_counts(k, 0);
        remainder_counts[0] = 1;

        for (int num : nums) {
            if (num % 2 != 0) {
                current_odd_count++;
            }

            int current_remainder = current_odd_count % k;

            ans += remainder_counts[current_remainder];

            remainder_counts[current_remainder]++;
        }

        return ans;
    }
};