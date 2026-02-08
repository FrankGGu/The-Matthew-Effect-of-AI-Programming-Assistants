var minCut = function(s) {
    const n = s.length;
    const isPalindrome = Array(n).fill(null).map(() => Array(n).fill(false));
    const dp = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i] = i;
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= i; j++) {
            if (s[i] === s[j] && (i - j <= 2 || isPalindrome[j + 1][i - 1])) {
                isPalindrome[j][i] = true;
                if (j === 0) {
                    dp[i] = 0;
                } else {
                    dp[i] = Math.min(dp[i], dp[j - 1] + 1);
                }
            }
        }
    }

    return dp[n - 1];
};