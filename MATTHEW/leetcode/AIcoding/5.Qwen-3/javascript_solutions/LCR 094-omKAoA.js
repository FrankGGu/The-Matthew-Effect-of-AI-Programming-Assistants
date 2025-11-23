function minCut(s) {
    const n = s.length;
    const isPalindrome = Array.from({ length: n }, () => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= i; j++) {
            if (s[i] === s[j] && (i - j <= 2 || isPalindrome[j + 1][i - 1])) {
                isPalindrome[j][i] = true;
            }
        }
    }

    const dp = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i] = i;
        for (let j = 0; j <= i; j++) {
            if (isPalindrome[j][i]) {
                dp[i] = Math.min(dp[i], j === 0 ? 0 : dp[j - 1] + 1);
            }
        }
    }

    return dp[n - 1];
}