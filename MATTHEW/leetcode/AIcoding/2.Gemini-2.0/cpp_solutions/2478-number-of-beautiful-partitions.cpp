#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int numberOfBeautifulPartitions(string s, int k, int minLength) {
        int n = s.size();
        int mod = 1e9 + 7;

        vector<bool> prime(10, true);
        prime[0] = prime[1] = false;
        prime[2] = true;
        prime[3] = true;
        prime[5] = true;
        prime[7] = true;

        if (!prime[s[0] - '0']) return 0;
        if (!prime[s[n - 1] - '0']) return 0;

        vector<int> good;
        for (int i = 0; i < n; ++i) {
            if (prime[s[i] - '0']) {
                good.push_back(i);
            }
        }

        vector<vector<int>> dp(good.size() + 1, vector<int>(k + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= good.size(); ++i) {
            for (int j = 1; j <= k; ++j) {
                for (int l = 0; l < i; ++l) {
                    if (good[i - 1] - (l == 0 ? -1 : good[l - 1]) >= minLength) {
                        dp[i][j] = (dp[i][j] + dp[l][j - 1]) % mod;
                    }
                }
            }
        }

        if (good.back() == n - 1) {
            return dp[good.size()][k];
        } else {
            return 0;
        }
    }
};