int maxPalindromes(char * s, int k) {
    int n = strlen(s);
    int count = 0;
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int len = j - i + 1;
            if (len >= k && isPalindrome(s, i, j)) {
                dp[j + 1] = fmax(dp[j + 1], dp[i] + 1);
            }
        }
    }

    return dp[n];
}

bool isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}