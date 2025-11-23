#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double new21Game(int n, int k, int maxPts) {
    if (k == 0 || n >= k + maxPts) return 1.0;
    double dp[n + 1];
    for (int i = 0; i <= n; i++) dp[i] = 0.0;
    dp[0] = 1.0;
    double sum = (k > 0) ? 1.0 : 0.0;
    double ans = 0.0;
    for (int i = 1; i <= n; i++) {
        dp[i] = sum / maxPts;
        if (i < k) sum += dp[i];
        else ans += dp[i];
        if (i - maxPts >= 0 && i - maxPts < k) sum -= dp[i - maxPts];
    }
    return ans;
}