#include <vector>
#include <numeric>
#include <unordered_map>

class Solution {
public:
    int sumCounts(std::vector<int>& nums) {
        const int N = nums.size();
        const int MOD = 1e9 + 7;

        std::unordered_map<int, int> last_pos;
        std::vector<int> prev(N);

        for (int i = 0; i < N; ++i) {
            if (last_pos.count(nums[i])) {
                prev[i] = last_pos[nums[i]];
            } else {
                prev[i] = -1;
            }
            last_pos[nums[i]] = i;
        }

        long long total_sum = 0;
        long long current_prefix_sum_of_contributions = 0;

        for (int j = 0; j < N; ++j) {
            long long val_sq_mod = (static_cast<long long>(nums[j]) * nums[j]) % MOD;

            long long num_i_for_j;
            if (prev[j] == -1) {
                // For nums[j], it's the first occurrence of this value up to index j.
                // It contributes nums[j]^2 to subarrays [i, j] where i can be 0, ..., j.
                // The number of such 'i's is (j - 0 + 1) = j + 1.
                num_i_for_j = j + 1;
            } else {
                // For nums[j], its previous occurrence was at prev[j].
                // It contributes nums[j]^2 to subarrays [i, j] where i can be prev[j] + 1, ..., j.
                // The number of such 'i's is (j - (prev[j] + 1) + 1) = j - prev[j].
                num_i_for_j = j - prev[j];
            }

            long long term = (val_sq_mod * num_i_for_j) % MOD;

            current_prefix_sum_of_contributions = (current_prefix_sum_of_contributions + term) % MOD;
            total_sum = (total_sum + current_prefix_sum_of_contributions) % MOD;
        }

        return static_cast<int>(total_sum);
    }
};