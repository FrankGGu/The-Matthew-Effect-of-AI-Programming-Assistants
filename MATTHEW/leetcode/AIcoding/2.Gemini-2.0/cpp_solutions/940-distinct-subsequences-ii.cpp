#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int distinctSubseqII(string s) {
        int n = s.length();
        long long mod = 1e9 + 7;
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;
        vector<int> last(26, -1);

        for (int i = 1; i <= n; ++i) {
            dp[i] = (2 * dp[i - 1]) % mod;
            int c = s[i - 1] - 'a';
            if (last[c] != -1) {
                dp[i] = (dp[i] - dp[last[c]] + mod) % mod;
            }
            last[c] = i - 1;
        }

        return (dp[n] - 1 + mod) % mod;
    }
};