#include <vector>
#include <numeric>

class Solution {
public:
    int subarraysDivByK(std::vector<int>& nums, int k) {
        std::vector<int> remainder_counts(k, 0);
        remainder_counts[0] = 1; // For prefix sum 0 before any elements
        int current_sum = 0;
        int ans = 0;

        for (int num : nums) {
            current_sum += num;
            // Calculate remainder, ensuring it's non-negative
            int remainder = (current_sum % k + k) % k;

            ans += remainder_counts[remainder];
            remainder_counts[remainder]++;
        }

        return ans;
    }
};