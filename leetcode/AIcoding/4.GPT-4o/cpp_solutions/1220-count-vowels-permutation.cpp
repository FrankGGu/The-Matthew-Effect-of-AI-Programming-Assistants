class Solution {
public:
    int countVowelPermutation(int n) {
        const int MOD = 1e9 + 7;
        vector<long> dp(5, 1);
        vector<long> temp(5);

        for (int i = 1; i < n; ++i) {
            temp[0] = (dp[1] + dp[2] + dp[4]) % MOD; // 'a'
            temp[1] = (dp[0] + dp[2]) % MOD;        // 'e'
            temp[2] = (dp[1] + dp[3]) % MOD;        // 'i'
            temp[3] = (dp[2]) % MOD;                 // 'o'
            temp[4] = (dp[2] + dp[3]) % MOD;        // 'u'
            dp = temp;
        }

        long result = 0;
        for (int i = 0; i < 5; ++i) {
            result = (result + dp[i]) % MOD;
        }

        return result;
    }
};