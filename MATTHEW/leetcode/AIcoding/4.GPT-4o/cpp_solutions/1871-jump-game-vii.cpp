class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        int n = s.size();
        if (s[0] == '1' || s[n - 1] == '1') return false;
        vector<int> dp(n, 0);
        dp[0] = 1;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (i > 0) sum += dp[i - 1];
            if (i >= minJump) sum -= dp[i - minJump];
            if (s[i] == '0' && sum > 0) dp[i] = 1;
            if (i >= maxJump) sum -= dp[i - maxJump];
        }
        return dp[n - 1] == 1;
    }
};