function minimumChanges(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(k + 1).fill(0));
    const cost = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let l = i, r = j;
            let c = 0;
            while (l < r) {
                if (s[l] !== s[r]) c++;
                l++;
                r--;
            }
            cost[i][j] = c;
        }
    }

    for (let i = 0; i < n; i++) {
        dp[i][1] = cost[0][i];
    }

    for (let m = 2; m <= k; m++) {
        for (let i = 0; i < n; i++) {
            dp[i][m] = Infinity;
            for (let j = m - 2; j < i; j++) {
                if (dp[j][m - 1] + cost[j + 1][i] < dp[i][m]) {
                    dp[i][m] = dp[j][m - 1] + cost[j + 1][i];
                }
            }
        }
    }

    return dp[n - 1][k];
}