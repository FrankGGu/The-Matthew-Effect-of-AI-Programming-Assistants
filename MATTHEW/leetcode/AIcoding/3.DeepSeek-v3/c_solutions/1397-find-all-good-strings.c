int dp[501][51][2][2];
int mod = 1e9 + 7;

void buildLPS(char *pattern, int *lps) {
    int len = 0;
    lps[0] = 0;
    int i = 1;
    int m = strlen(pattern);
    while (i < m) {
        if (pattern[i] == pattern[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
}

int dfs(char *s, char *evil, int *lps, int n, int pos, int evilPos, int isLimit, int isEvil) {
    if (evilPos == strlen(evil)) return 0;
    if (pos == n) return 1;
    if (dp[pos][evilPos][isLimit][isEvil] != -1) return dp[pos][evilPos][isLimit][isEvil];

    int res = 0;
    char limit = isLimit ? s[pos] : 'z';
    for (char c = 'a'; c <= limit; c++) {
        int newEvilPos = evilPos;
        if (isEvil) {
            while (newEvilPos > 0 && evil[newEvilPos] != c) {
                newEvilPos = lps[newEvilPos - 1];
            }
            if (evil[newEvilPos] == c) {
                newEvilPos++;
            }
        } else {
            newEvilPos = (c == evil[0]) ? 1 : 0;
        }
        int newIsEvil = (newEvilPos == strlen(evil)) ? 0 : 1;
        int newIsLimit = (isLimit && c == limit) ? 1 : 0;
        res = (res + dfs(s, evil, lps, n, pos + 1, newEvilPos, newIsLimit, newIsEvil)) % mod;
    }
    return dp[pos][evilPos][isLimit][isEvil] = res;
}

int findGoodStrings(int n, char *s1, char *s2, char *evil) {
    int m = strlen(evil);
    int lps[51];
    buildLPS(evil, lps);

    memset(dp, -1, sizeof(dp));
    int total = dfs(s2, evil, lps, n, 0, 0, 1, 1);

    memset(dp, -1, sizeof(dp));
    int subtract = dfs(s1, evil, lps, n, 0, 0, 1, 1);

    int ans = (total - subtract + mod) % mod;

    if (strstr(s1, evil) == NULL) ans = (ans + 1) % mod;
    return ans;
}