class Solution {
public:
    int findSubstringInWraproundString(string p) {
        vector<int> dp(26, 0);
        int maxLength = 0;

        for (int i = 0; i < p.size(); i++) {
            maxLength = (i > 0 && (p[i] - p[i - 1] + 26) % 26 == 1) ? maxLength + 1 : 1;
            dp[p[i] - 'a'] = max(dp[p[i] - 'a'], maxLength);
        }

        return accumulate(dp.begin(), dp.end(), 0);
    }
};