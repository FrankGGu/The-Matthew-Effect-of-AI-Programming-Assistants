int maxPalindromes(char * s, int k){
    int n = strlen(s);
    int dp[n + 1];
    for (int i = 0; i <= n; i++) dp[i] = 0;

    for (int i = 0; i < n; i++) {
        dp[i + 1] = dp[i];
        for (int j = i - k + 1; j >= 0; j--) {
            if (dp[j] + 1 <= dp[i + 1]) continue;
            int left = j, right = i;
            int valid = 1;
            while (left < right) {
                if (s[left] != s[right]) {
                    valid = 0;
                    break;
                }
                left++;
                right--;
            }
            if (valid) {
                dp[i + 1] = dp[j] + 1;
            }
        }
    }
    return dp[n];
}