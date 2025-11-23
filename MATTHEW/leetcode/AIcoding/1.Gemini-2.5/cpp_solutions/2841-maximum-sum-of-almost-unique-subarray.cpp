#include <vector>
#include <numeric>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    long long maximumSum(std::vector<int>& nums, int m, int k) {
        long long max_sum = 0;
        long long current_sum = 0;
        std::unordered_map<int, int> counts;
        int unique_count = 0;

        for (int i = 0; i < nums.size(); ++i) {
            // Add current element to the window
            current_sum += nums[i];
            if (counts[nums[i]] == 0) {
                unique_count++;
            }
            counts[nums[i]]++;

            // If window size exceeds k, remove the leftmost element
            if (i >= k) {
                int left_val = nums[i - k];
                current_sum -= left_val;
                counts[left_val]--;
                if (counts[left_val] == 0) {
                    unique_count--;
                }
            }

            // If window has exactly k elements, check conditions
            if (i >= k - 1) {
                if (unique_count >= m) {
                    max_sum = std::max(max_sum, current_sum);
                }
            }
        }

        return max_sum;
    }
};