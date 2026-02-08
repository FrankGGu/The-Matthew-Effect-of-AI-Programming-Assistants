var palindromePartition = function(s, k) {
    const n = s.length;
    const cost = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let l = i, r = j;
            while (l < r) {
                if (s[l] !== s[r]) {
                    cost[i][j]++;
                }
                l++;
                r--;
            }
        }
    }

    const dp = Array(n + 1).fill(null).map(() => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            for (let x = 1; x <= i; x++) {
                dp[i][j] = Math.min(dp[i][j], dp[i - x][j - 1] + cost[i - x][i - 1]);
            }
        }
    }

    return dp[n][k];
};