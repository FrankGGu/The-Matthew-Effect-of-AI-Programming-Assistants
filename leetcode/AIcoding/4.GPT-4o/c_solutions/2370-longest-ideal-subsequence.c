int longestIdealSubstring(char *s, int k) {
    int dp[128] = {0}, maxLength = 0;
    for (int i = 0; s[i]; i++) {
        int index = (int)s[i];
        int currentLength = 1;
        for (int j = index - k; j <= index + k; j++) {
            if (j >= 0 && j < 128) {
                currentLength = fmax(currentLength, dp[j] + 1);
            }
        }
        dp[index] = currentLength;
        maxLength = fmax(maxLength, currentLength);
    }
    return maxLength;
}