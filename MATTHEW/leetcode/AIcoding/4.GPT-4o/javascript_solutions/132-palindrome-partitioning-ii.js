var minCut = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    const isPalindrome = new Array(n).fill(0).map(() => new Array(n).fill(false));

    for (let i = 0; i <= n; i++) {
        dp[i] = n - 1 - i;
    }

    for (let end = 0; end < n; end++) {
        for (let start = end; start >= 0; start--) {
            if (s[start] === s[end] && (end - start <= 2 || isPalindrome[start + 1][end - 1])) {
                isPalindrome[start][end] = true;
                dp[start] = Math.min(dp[start], dp[end + 1] + 1);
            }
        }
    }

    return dp[0];
};