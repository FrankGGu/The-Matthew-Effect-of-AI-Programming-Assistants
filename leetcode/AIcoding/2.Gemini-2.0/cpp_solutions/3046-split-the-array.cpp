#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool splitArray(vector<int>& nums) {
        int n = nums.size();
        if (n < 7) return false;

        vector<int> sum(n, 0);
        sum[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            sum[i] = sum[i - 1] + nums[i];
        }

        for (int j = 3; j < n - 3; ++j) {
            for (int i = 1; i < j - 1; ++i) {
                if (sum[i - 1] == sum[j - 1] - sum[i]) {
                    for (int k = j + 2; k < n - 1; ++k) {
                        if (sum[k - 1] - sum[j] == sum[n - 1] - sum[k] && sum[k - 1] - sum[j] == sum[i - 1]) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }
};