function minCut(s) {
    const n = s.length;
    const dp = new Array(n).fill(0);
    const isPalindrome = new Array(n).fill(false).map(() => new Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        let min = i;
        for (let j = 0; j <= i; j++) {
            if (s[j] === s[i] && (i - j <= 2 || isPalindrome[j + 1][i - 1])) {
                isPalindrome[j][i] = true;
                min = Math.min(min, dp[j] + 1);
            }
        }
        dp[i] = min;
    }

    return dp[n - 1];
}