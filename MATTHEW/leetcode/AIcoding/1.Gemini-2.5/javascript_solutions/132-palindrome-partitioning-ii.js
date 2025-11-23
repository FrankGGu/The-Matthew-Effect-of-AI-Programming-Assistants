var minCut = function(s) {
    const n = s.length;

    if (n === 0) {
        return 0;
    }

    const isPalindrome = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i; j < n; j++) {
            if (s[i] === s[j] && (j - i <= 1 || isPalindrome[i + 1][j - 1])) {
                isPalindrome[i][j] = true;
            }
        }
    }

    const dp = Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < i; j++) {
            if (isPalindrome[j][i - 1]) {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n] - 1; 
};