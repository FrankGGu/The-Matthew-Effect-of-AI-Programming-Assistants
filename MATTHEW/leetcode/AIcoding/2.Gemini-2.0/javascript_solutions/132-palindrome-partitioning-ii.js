var minCut = function(s) {
    const n = s.length;
    const isPalindrome = Array(n).fill(null).map(() => Array(n).fill(false));
    const dp = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let minCuts = i;
        for (let j = 0; j <= i; j++) {
            if (s[i] === s[j] && (i - j <= 2 || isPalindrome[j + 1][i - 1])) {
                isPalindrome[j][i] = true;
                minCuts = j === 0 ? 0 : Math.min(minCuts, dp[j - 1] + 1);
            }
        }
        dp[i] = minCuts;
    }

    return dp[n - 1];
};