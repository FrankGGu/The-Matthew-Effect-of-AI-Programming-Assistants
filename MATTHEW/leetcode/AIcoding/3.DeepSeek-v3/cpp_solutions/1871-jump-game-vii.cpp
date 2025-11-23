class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        int n = s.size();
        if (s[n-1] != '0') return false;
        vector<bool> dp(n, false);
        dp[0] = true;
        int pre = 0;
        for (int i = 1; i < n; ++i) {
            if (i >= minJump && dp[i - minJump]) pre++;
            if (i > maxJump && dp[i - maxJump - 1]) pre--;
            dp[i] = (s[i] == '0' && pre > 0);
        }
        return dp[n-1];
    }
};