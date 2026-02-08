#include <vector>

using namespace std;

long long countKReducibleNumbers(long long n, int k) {
    string s = to_string(n);
    int len = s.length();
    vector<vector<long long>> dp(len + 1, vector<long long>(k, 0));
    dp[0][0] = 1;

    for (int i = 1; i <= len; ++i) {
        for (int j = 0; j < k; ++j) {
            for (int d = 0; d < s[i - 1] - '0'; ++d) {
                dp[i][(j * 10 + d) % k] += dp[i - 1][j];
            }
            dp[i][(j * 10 + (s[i - 1] - '0')) % k] += dp[i - 1][j];
        }
    }

    long long ans = dp[len][0];

    long long num = 0;
    for(int i = 1; i < len; ++i){
        long long temp = 1;
        for(int j = 1; j < i; ++j){
            temp *= 10;
        }

        long long count = 0;
        for(long long d = 1; d <= 9; ++d){
            if(d % k == 0) count++;
        }
        for(int j = 1; j < i; ++j){
            long long tempCount = 0;
            for(long long d = 0; d <= 9; ++d){
                if(d % k == 0) tempCount++;
            }
             count *= 10;
        }

         dp.assign(i + 1, vector<long long>(k, 0));
        dp[0][0] = 1;

        for (int x = 1; x <= i; ++x) {
            for (int j = 0; j < k; ++j) {
                for (int d = 0; d <= 9; ++d) {
                    dp[x][(j * 10 + d) % k] += dp[x - 1][j];
                }
            }
        }
        ans += dp[i][0];
    }

    return ans;
}