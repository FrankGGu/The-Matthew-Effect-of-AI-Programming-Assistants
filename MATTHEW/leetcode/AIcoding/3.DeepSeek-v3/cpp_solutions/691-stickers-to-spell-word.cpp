class Solution {
public:
    int minStickers(vector<string>& stickers, string target) {
        int n = target.size();
        vector<int> dp(1 << n, -1);
        dp[0] = 0;

        for (int state = 0; state < (1 << n); ++state) {
            if (dp[state] == -1) continue;
            for (const string& sticker : stickers) {
                int next_state = state;
                vector<int> cnt(26, 0);
                for (char c : sticker) {
                    cnt[c - 'a']++;
                }
                for (int i = 0; i < n; ++i) {
                    if (!(state & (1 << i)) && cnt[target[i] - 'a'] > 0) {
                        next_state |= (1 << i);
                        cnt[target[i] - 'a']--;
                    }
                }
                if (dp[next_state] == -1 || dp[next_state] > dp[state] + 1) {
                    dp[next_state] = dp[state] + 1;
                }
            }
        }
        return dp[(1 << n) - 1];
    }
};