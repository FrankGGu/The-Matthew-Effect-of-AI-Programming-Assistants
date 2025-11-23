#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> maxSumOfThreeSubarrays(std::vector<int>& nums, int k) {
        int n = nums.size();

        std::vector<int> W(n - k + 1);
        long long current_sum = 0;
        for (int i = 0; i < n; ++i) {
            current_sum += nums[i];
            if (i >= k) {
                current_sum -= nums[i - k];
            }
            if (i >= k - 1) {
                W[i - k + 1] = current_sum;
            }
        }

        int size_W = W.size();
        std::vector<int> left(size_W);
        int best_idx = 0;
        for (int i = 0; i < size_W; ++i) {
            if (W[i] > W[best_idx]) {
                best_idx = i;
            }
            left[i] = best_idx;
        }

        std::vector<int> right(size_W);
        best_idx = size_W - 1;
        for (int i = size_W - 1; i >= 0; --i) {
            if (W[i] >= W[best_idx]) {
                best_idx = i;
            }
            right[i] = best_idx;
        }

        std::vector<int> ans(3);
        int max_sum = 0;

        for (int j = k; j < size_W - k; ++j) {
            int i = left[j - k];
            int l = right[j + k];
            int current_total_sum = W[i] + W[j] + W[l];
            if (current_total_sum > max_sum) {
                max_sum = current_total_sum;
                ans = {i, j, l};
            }
        }

        return ans;
    }
};