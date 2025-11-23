class Solution {
public:
    int minStickers(vector<string>& stickers, string target) {
        int n = stickers.size();
        vector<int> dp(1 << target.size(), INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << target.size()); ++mask) {
            if (dp[mask] == INT_MAX) continue;

            for (const auto& sticker : stickers) {
                vector<int> count(26, 0);
                for (char c : sticker) count[c - 'a']++;

                int newMask = mask;
                for (int j = 0; j < target.size(); ++j) {
                    if ((mask & (1 << j)) == 0 && count[target[j] - 'a'] > 0) {
                        newMask |= (1 << j);
                        count[target[j] - 'a']--;
                    }
                }
                dp[newMask] = min(dp[newMask], dp[mask] + 1);
            }
        }
        return dp[(1 << target.size()) - 1] == INT_MAX ? -1 : dp[(1 << target.size()) - 1];
    }
};