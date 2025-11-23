#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int maxSumDivisibleByK(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> prefix_sums(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sums[i + 1] = (prefix_sums[i] + nums[i]) % k;
        }

        int max_len = 0;
        for (int i = 0; i < k; ++i) {
            int first = -1, last = -1;
            for (int j = 0; j <= n; ++j) {
                if (prefix_sums[j] == i) {
                    if (first == -1) {
                        first = j;
                    }
                    last = j;
                }
            }
            if (first != -1 && last != -1) {
                max_len = max(max_len, last - first);
            }
        }

        int max_sum = 0;
        for (int len = 1; len <= max_len; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int sum = 0;
                for (int j = i; j < i + len; ++j) {
                    sum += nums[j];
                }
                if (sum % k == 0) {
                    max_sum = max(max_sum, sum);
                }
            }
        }

        int ans = 0;
        for(int i = 0; i < n; i++) {
            for(int j = i; j < n; j++) {
                int sum = 0;
                for(int l = i; l <= j; l++) {
                    sum += nums[l];
                }
                if(sum % k == 0) {
                    ans = max(ans, sum);
                }
            }
        }

        return ans;
    }
};