int maxProduct(char* s) {
    int n = strlen(s);
    int total = 1 << n;
    int* dp = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < total; i++) {
        dp[i] = 0;
    }

    for (int mask = 1; mask < total; mask++) {
        int len = 0;
        int left = 0, right = n - 1;
        while (left <= right) {
            if ((mask & (1 << left)) == 0) {
                left++;
            } else if ((mask & (1 << right)) == 0) {
                right--;
            } else if (s[left] != s[right]) {
                len = 0;
                break;
            } else {
                len += (left == right) ? 1 : 2;
                left++;
                right--;
            }
        }
        dp[mask] = len;
    }

    int res = 0;
    for (int m1 = total - 1; m1 > 0; m1--) {
        if (dp[m1] * (n - dp[m1]) <= res) continue;
        for (int m2 = m1 - 1; m2 > 0; m2--) {
            if ((m1 & m2) == 0) {
                int product = dp[m1] * dp[m2];
                if (product > res) {
                    res = product;
                }
            }
        }
    }

    free(dp);
    return res;
}