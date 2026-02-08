class Solution {
public:
    const int MOD = 1e9 + 7;
    int findGoodStrings(int n, string s1, string s2, string evil) {
        int m = evil.size();
        vector<int> lps = computeLPS(evil);
        vector<vector<vector<vector<int>>>> dp(n, vector<vector<vector<int>>>(m, vector<vector<int>>(2, vector<int>(2, -1))));
        return dfs(0, 0, true, true, n, s1, s2, evil, lps, dp);
    }

    int dfs(int pos, int evilMatched, bool tight1, bool tight2, int n, string &s1, string &s2, string &evil, vector<int> &lps, vector<vector<vector<vector<int>>>> &dp) {
        if (evilMatched == evil.size()) return 0;
        if (pos == n) return 1;
        if (dp[pos][evilMatched][tight1][tight2] != -1) return dp[pos][evilMatched][tight1][tight2];

        char low = tight1 ? s1[pos] : 'a';
        char high = tight2 ? s2[pos] : 'z';

        long long res = 0;
        for (char c = low; c <= high; ++c) {
            bool newTight1 = tight1 && (c == s1[pos]);
            bool newTight2 = tight2 && (c == s2[pos]);

            int newEvilMatched = evilMatched;
            while (newEvilMatched > 0 && c != evil[newEvilMatched]) {
                newEvilMatched = lps[newEvilMatched - 1];
            }
            if (c == evil[newEvilMatched]) {
                newEvilMatched++;
            }

            res += dfs(pos + 1, newEvilMatched, newTight1, newTight2, n, s1, s2, evil, lps, dp);
            res %= MOD;
        }

        return dp[pos][evilMatched][tight1][tight2] = res;
    }

    vector<int> computeLPS(string &pattern) {
        int n = pattern.size();
        vector<int> lps(n, 0);
        for (int i = 1, len = 0; i < n; ) {
            if (pattern[i] == pattern[len]) {
                lps[i++] = ++len;
            } else if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i++] = 0;
            }
        }
        return lps;
    }
};