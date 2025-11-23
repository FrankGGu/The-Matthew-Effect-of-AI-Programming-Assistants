int minimumTime(int* nums1, int nums1Size, int* nums2, int nums2Size, int x) {
    int n = nums1Size;
    int dp[n+1];
    for (int i = 0; i <= n; i++) dp[i] = 0;

    int pairs[n][2];
    for (int i = 0; i < n; i++) {
        pairs[i][0] = nums2[i];
        pairs[i][1] = nums1[i];
    }

    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) {
            if (pairs[j][0] > pairs[j+1][0]) {
                int temp0 = pairs[j][0];
                int temp1 = pairs[j][1];
                pairs[j][0] = pairs[j+1][0];
                pairs[j][1] = pairs[j+1][1];
                pairs[j+1][0] = temp0;
                pairs[j+1][1] = temp1;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = i+1; j > 0; j--) {
            dp[j] = (dp[j] > dp[j-1] + pairs[i][0] * j + pairs[i][1]) ? dp[j] : dp[j-1] + pairs[i][0] * j + pairs[i][1];
        }
    }

    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < n; i++) {
        sum1 += nums1[i];
        sum2 += nums2[i];
    }

    for (int t = 0; t <= n; t++) {
        if (sum1 + sum2 * t - dp[t] <= x) {
            return t;
        }
    }

    return -1;
}