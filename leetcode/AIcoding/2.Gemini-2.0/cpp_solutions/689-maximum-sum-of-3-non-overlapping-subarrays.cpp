#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> maxSumOfThreeSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> sum(n - k + 1, 0);
        for (int i = 0; i < n - k + 1; ++i) {
            sum[i] = accumulate(nums.begin() + i, nums.begin() + i + k, 0LL);
        }

        vector<int> left(n - k + 1, 0);
        long long max_sum = sum[0];
        for (int i = 1; i < n - k + 1; ++i) {
            if (sum[i] > max_sum) {
                max_sum = sum[i];
                left[i] = i;
            } else {
                left[i] = left[i - 1];
            }
        }

        vector<int> right(n - k + 1, n - k);
        max_sum = sum[n - k];
        for (int i = n - k - 1; i >= 0; --i) {
            if (sum[i] >= max_sum) {
                max_sum = sum[i];
                right[i] = i;
            } else {
                right[i] = right[i + 1];
            }
        }

        vector<int> ans(3, 0);
        long long max_total = 0;
        for (int j = k; j < n - 2 * k + 1; ++j) {
            long long total = sum[left[j - k]] + sum[j] + sum[right[j + k]];
            if (total > max_total) {
                max_total = total;
                ans[0] = left[j - k];
                ans[1] = j;
                ans[2] = right[j + k];
            }
        }

        return ans;
    }
};