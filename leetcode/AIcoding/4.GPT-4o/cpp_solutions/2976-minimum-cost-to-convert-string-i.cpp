class Solution {
public:
    int minimumCost(string s) {
        int n = s.size();
        if (n == 0) return 0;

        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + (s[i - 1] - 'a' + 1);
            for (int j = 1; j <= i; ++j) {
                dp[i] = min(dp[i], dp[j - 1] + cost(s.substr(j - 1, i - j + 1)));
            }
        }

        return dp[n];
    }

    int cost(const string& sub) {
        int cost = 0;
        for (char c : sub) {
            cost += c - 'a' + 1;
        }
        return cost;
    }
};