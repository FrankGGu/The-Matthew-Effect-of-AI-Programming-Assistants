class Solution {
public:
    int maximumPalindromes(string s, int k) {
        int n = s.size();
        vector<int> dp(n + 1, 0);
        vector<int> count(26, 0);
        int ans = 0;

        for (int i = 0; i < n; ++i) {
            count[s[i] - 'a']++;
            if (count[s[i] - 'a'] == 1) {
                dp[i + 1] = dp[i] + 1;
            } else {
                dp[i + 1] = dp[i];
            }

            if (i >= k - 1) {
                int cnt = 0;
                for (int j = 0; j < 26; ++j) {
                    if (count[j] > 0) cnt++;
                }
                ans = max(ans, dp[i + 1] + min(cnt, (i + 1) / 2));
                count[s[i - k + 1] - 'a']--;
                if (count[s[i - k + 1] - 'a'] == 0) {
                    cnt--;
                }
            }
        }

        return ans;
    }
};