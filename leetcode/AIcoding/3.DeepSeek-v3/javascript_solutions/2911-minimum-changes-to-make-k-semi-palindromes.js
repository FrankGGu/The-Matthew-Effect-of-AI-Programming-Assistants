var minimumChanges = function(s, k) {
    const n = s.length;
    const memo = new Array(n).fill().map(() => new Array(n).fill(-1));

    function isSemiPalindrome(l, r) {
        if (memo[l][r] !== -1) return memo[l][r];
        let minChanges = Infinity;
        const len = r - l + 1;
        for (let d = 1; d <= len / 2; d++) {
            if (len % d !== 0) continue;
            let changes = 0;
            for (let i = 0; i < d; i++) {
                let left = l + i;
                let right = r - d + 1 + i;
                while (left < right) {
                    if (s[left] !== s[right]) changes++;
                    left += d;
                    right -= d;
                }
            }
            minChanges = Math.min(minChanges, changes);
        }
        memo[l][r] = minChanges;
        return minChanges;
    }

    const dp = new Array(k + 1).fill().map(() => new Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        dp[1][i] = isSemiPalindrome(0, i);
    }

    for (let i = 2; i <= k; i++) {
        for (let j = i - 1; j < n; j++) {
            for (let p = i - 2; p < j; p++) {
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][p] + isSemiPalindrome(p + 1, j));
            }
        }
    }

    return dp[k][n - 1];
};