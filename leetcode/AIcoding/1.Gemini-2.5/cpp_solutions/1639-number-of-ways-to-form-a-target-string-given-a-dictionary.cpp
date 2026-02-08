#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numWays(vector<string>& words, string target) {
        int n = target.length();
        int m = words[0].length();
        long long mod = 1e9 + 7;
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;
        vector<vector<int>> count(m, vector<int>(26, 0));
        for (int j = 0; j < m; j++) {
            for (string& word : words) {
                count[j][word[j] - 'a']++;
            }
        }
        for (int j = 0; j < m; j++) {
            for (int i = n - 1; i >= 0; i--) {
                dp[i + 1] = (dp[i + 1] + dp[i] * count[j][target[i] - 'a']) % mod;
            }
        }
        return dp[n];
    }
};