int numberOfCombinations(char* num) {
    int n = strlen(num);
    if (num[0] == '0') return 0;

    int MOD = 1000000007;

    // lcp[i][j] = length of longest common prefix of num[i..] and num[j..]
    int lcp[n+1][n+1];
    for (int i = n; i >= 0; i--) {
        for (int j = n; j >= 0; j--) {
            if (i == n || j == n) {
                lcp[i][j] = 0;
            } else if (num[i] == num[j]) {
                lcp[i][j] = lcp[i+1][j+1] + 1;
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    // dp[i][j] = number of ways to split num[0..i] with last segment num[j..i]
    int dp[n][n];
    memset(dp, 0, sizeof(dp));

    // prefix sum array for dp
    int prefix[n][n];
    memset(prefix, 0, sizeof(prefix));

    // Initialize for first digit
    for (int i = 0; i < n; i++) {
        dp[0][i] = (i == 0) ? 1 : 0;
        prefix[0][i] = (i == 0) ? 1 : 0;
    }

    for (int i = 1; i < n; i++) {
        for (int j = 0; j <= i; j++) {
            if (num[j] == '0') {
                dp[i][j] = 0;
            } else {
                int len = i - j + 1;
                int prev_start = j - 1;
                int prev_end = j - 1;

                if (prev_start < 0) {
                    // This is the first segment
                    dp[i][j] = 1;
                } else {
                    // Find the maximum possible start for previous segment
                    int max_prev_start = prev_start - len + 1;
                    if (max_prev_start < 0) max_prev_start = 0;

                    // Check if we need to compare lexicographically
                    int compare = 0;
                    if (prev_start - max_prev_start + 1 == len) {
                        // Same length, need to compare
                        int common = lcp[max_prev_start][j];
                        if (common < len && num[max_prev_start + common] < num[j + common]) {
                            compare = 1;
                        }
                    }

                    if (max_prev_start > 0 && compare) {
                        dp[i][j] = (prefix[j-1][prev_start] - prefix[j-1][max_prev_start-1] + MOD) % MOD;
                    } else {
                        dp[i][j] = prefix[j-1][prev_start];
                    }
                }
            }

            // Update prefix sum
            if (j == 0) {
                prefix[i][j] = dp[i][j];
            } else {
                prefix[i][j] = (prefix[i][j-1] + dp[i][j]) % MOD;
            }
        }

        // Fill the remaining prefix sums for positions beyond i
        for (int j = i+1; j < n; j++) {
            prefix[i][j] = prefix[i][i];
        }
    }

    int result = 0;
    for (int j = 0; j < n; j++) {
        result = (result + dp[n-1][j]) % MOD;
    }

    return result;
}