function palindromePartitioning(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            let min = Infinity;
            for (let m = j - 1; m < i; m++) {
                if (dp[m][j - 1] !== Infinity) {
                    const cost = getCost(s, m, i - 1);
                    min = Math.min(min, dp[m][j - 1] + cost);
                }
            }
            dp[i][j] = min;
        }
    }

    return dp[n][k];
}

function getCost(s, left, right) {
    let cost = 0;
    while (left < right) {
        if (s[left] !== s[right]) {
            cost++;
        }
        left++;
        right--;
    }
    return cost;
}