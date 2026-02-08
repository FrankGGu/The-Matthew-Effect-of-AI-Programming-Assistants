var minCut = function(s) {
    const n = s.length;
    const isPalindrome = Array.from({ length: n }, () => Array(n).fill(false));
    const dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let min = i;
        for (let j = 0; j <= i; j++) {
            if (s[i] === s[j] && (i - j <= 2 || isPalindrome[j + 1][i - 1])) {
                isPalindrome[j][i] = true;
                min = j === 0 ? 0 : Math.min(min, dp[j - 1] + 1);
            }
        }
        dp[i] = min;
    }

    return dp[n - 1];
};