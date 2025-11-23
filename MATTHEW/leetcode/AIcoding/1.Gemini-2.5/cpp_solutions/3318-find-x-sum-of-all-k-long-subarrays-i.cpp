#include <vector>
#include <numeric>

class Solution {
public:
    long long findXSum(std::vector<int>& nums, int k) {
        long long total_x_sum = 0;
        int n = nums.size();
        if (n < k) {
            return 0;
        }

        std::vector<int> bit_counts(30, 0);

        for (int i = 0; i < k; ++i) {
            for (int j = 0; j < 30; ++j) {
                if ((nums[i] >> j) & 1) {
                    bit_counts[j]++;
                }
            }
        }

        long long current_or = 0;
        long long current_and = 0;
        for (int j = 0; j < 30; ++j) {
            if (bit_counts[j] > 0) {
                current_or |= (1LL << j);
            }
            if (bit_counts[j] == k) {
                current_and |= (1LL << j);
            }
        }
        total_x_sum += current_or * current_and;

        for (int i = 1; i <= n - k; ++i) {
            int left_val = nums[i - 1];
            for (int j = 0; j < 30; ++j) {
                if ((left_val >> j) & 1) {
                    bit_counts[j]--;
                }
            }

            int right_val = nums[i + k - 1];
            for (int j = 0; j < 30; ++j) {
                if ((right_val >> j) & 1) {
                    bit_counts[j]++;
                }
            }

            current_or = 0;
            current_and = 0;
            for (int j = 0; j < 30; ++j) {
                if (bit_counts[j] > 0) {
                    current_or |= (1LL << j);
                }
                if (bit_counts[j] == k) {
                    current_and |= (1LL << j);
                }
            }
            total_x_sum += current_or * current_and;
        }

        return total_x_sum;
    }
};