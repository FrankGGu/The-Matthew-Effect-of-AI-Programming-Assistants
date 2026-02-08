#include <vector>

using namespace std;

class Solution {
public:
    int countSubMultisets(vector<int>& nums, int l, int r) {
        int countZero = 0;
        vector<int> nonZero;
        for (int num : nums) {
            if (num == 0) {
                countZero++;
            } else {
                nonZero.push_back(num);
            }
        }

        int n = nonZero.size();
        int maxSum = r;
        vector<int> dp(maxSum + 1, 0);
        dp[0] = 1;

        for (int num : nonZero) {
            for (int i = num; i <= maxSum; i++) {
                dp[i] = (dp[i] + dp[i - num]) % 1000000007;
            }
        }

        long long ans = 0;
        long long pow2 = 1;
        for (int i = 0; i < countZero; i++) {
            pow2 = (pow2 * 2) % 1000000007;
        }

        for (int i = l; i <= r; i++) {
            ans = (ans + (long long)dp[i]) % 1000000007;
        }

        ans = (ans * pow2) % 1000000007;
        return (int)ans;
    }
};