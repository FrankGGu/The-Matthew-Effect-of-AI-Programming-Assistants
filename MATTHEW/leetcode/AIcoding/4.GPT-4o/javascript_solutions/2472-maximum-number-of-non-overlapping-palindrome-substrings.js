var maxPalindromes = function(s, k) {
    const n = s.length;
    const isPalindrome = Array(n).fill(false).map(() => Array(n).fill(false));

    for (let len = 1; len <= n; len++) {
        for (let i = 0; i + len - 1 < n; i++) {
            const j = i + len - 1;
            if (len === 1) {
                isPalindrome[i][j] = true;
            } else if (len === 2) {
                isPalindrome[i][j] = s[i] === s[j];
            } else {
                isPalindrome[i][j] = s[i] === s[j] && isPalindrome[i + 1][j - 1];
            }
        }
    }

    const dp = Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (let j = i - 1; j >= 0; j--) {
            if (isPalindrome[j][i - 1] && (i - j) >= k) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n];
};