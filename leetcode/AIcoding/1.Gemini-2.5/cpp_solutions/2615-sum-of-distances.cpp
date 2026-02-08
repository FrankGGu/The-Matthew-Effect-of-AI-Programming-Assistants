#include <vector>
#include <map>
#include <numeric>

class Solution {
public:
    std::vector<long long> sumOfDistances(std::vector<int>& nums) {
        std::map<int, std::vector<int>> val_to_indices;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            val_to_indices[nums[i]].push_back(i);
        }

        std::vector<long long> ans(n);

        for (auto const& [val, indices] : val_to_indices) {
            int k = indices.size();
            if (k <= 1) {
                // If a number appears only once, the sum of distances is 0.
                // ans[indices[0]] would already be 0, so no action needed.
                continue;
            }

            std::vector<long long> prefix_sum(k + 1, 0);
            for (int j = 0; j < k; ++j) {
                prefix_sum[j+1] = prefix_sum[j] + indices[j];
            }

            for (int p = 0; p < k; ++p) {
                long long current_index = indices[p];

                // Sum of (current_index - i_q) for q < p
                // This is p * current_index - (sum of i_q for q < p)
                long long sum_left = (long long)p * current_index - prefix_sum[p];

                // Sum of (i_q - current_index) for q > p
                // This is (sum of i_q for q > p) - (k - 1 - p) * current_index
                // sum of i_q for q > p = (total sum of indices) - (sum of indices up to p)
                long long sum_right = (prefix_sum[k] - prefix_sum[p+1]) - (long long)(k - 1 - p) * current_index;

                ans[current_index] = sum_left + sum_right;
            }
        }

        return ans;
    }
};