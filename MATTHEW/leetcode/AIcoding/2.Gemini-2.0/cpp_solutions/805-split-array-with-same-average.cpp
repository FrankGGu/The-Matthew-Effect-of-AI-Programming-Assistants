#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    bool splitArraySameAverage(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return false;

        int sum = accumulate(nums.begin(), nums.end(), 0);

        for (int len = 1; len < n; ++len) {
            if ((sum * len) % n == 0) {
                int targetSum = (sum * len) / n;
                vector<vector<bool>> dp(len + 1, vector<bool>(targetSum + 1, false));
                dp[0][0] = true;

                for (int num : nums) {
                    for (int i = len; i >= 1; --i) {
                        for (int j = targetSum; j >= num; --j) {
                            dp[i][j] = dp[i][j] || dp[i - 1][j - num];
                        }
                    }
                }

                if (dp[len][targetSum]) return true;
            }
        }

        return false;
    }
};