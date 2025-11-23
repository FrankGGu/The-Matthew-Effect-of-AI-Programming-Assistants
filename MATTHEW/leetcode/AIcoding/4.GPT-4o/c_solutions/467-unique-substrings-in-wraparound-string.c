int findSubstringInWraproundString(char * p) {
    int dp[26] = {0};
    int maxLength = 0;

    for (int i = 0; p[i] != '\0'; i++) {
        if (i > 0 && (p[i] - p[i - 1] + 26) % 26 == 1) {
            maxLength++;
        } else {
            maxLength = 1;
        }
        dp[p[i] - 'a'] = fmax(dp[p[i] - 'a'], maxLength);
    }

    int result = 0;
    for (int i = 0; i < 26; i++) {
        result += dp[i];
    }

    return result;
}