#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPartitionsAfterOperations(int n, vector<int>& nums) {
        vector<int> distinct(n);
        for (int i = 0; i < n; ++i) {
            distinct[i] = 0;
            vector<bool> seen(26, false);
            int num = nums[i];
            while (num > 0) {
                int digit = num % 10;
                if (!seen[digit]) {
                    distinct[i]++;
                    seen[digit] = true;
                }
                num /= 10;
            }
        }

        int dp[2][1024];
        for (int i = 0; i < 2; ++i) {
            for (int j = 0; j < 1024; ++j) {
                dp[i][j] = 0;
            }
        }

        dp[0][0] = 0;
        dp[0][1023] = 1;

        for (int i = 0; i < n; ++i) {
            int curr = (i + 1) % 2;
            int prev = i % 2;
            for (int j = 0; j < 1024; ++j) {
                dp[curr][j] = 0;
            }

            for (int j = 0; j < 1024; ++j) {
                if (dp[prev][j] > 0) {
                    dp[curr][j | distinct[i]] = max(dp[curr][j | distinct[i]], dp[prev][j]);
                    dp[curr][j] = max(dp[curr][j], dp[prev][j] + 1);
                }
            }
        }

        return dp[n % 2][0];
    }
};