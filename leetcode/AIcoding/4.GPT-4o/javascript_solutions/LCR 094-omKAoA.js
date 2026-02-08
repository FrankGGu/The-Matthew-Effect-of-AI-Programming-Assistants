var minCut = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    const isPalindrome = Array.from({ length: n }, () => new Array(n).fill(false));

    for (let i = 0; i <= n; i++) {
        dp[i] = i - 1;
    }

    for (let right = 0; right < n; right++) {
        for (let left = 0; left <= right; left++) {
            if (s[left] === s[right] && (right - left <= 2 || isPalindrome[left + 1][right - 1])) {
                isPalindrome[left][right] = true;
                dp[right + 1] = Math.min(dp[right + 1], dp[left] + 1);
            }
        }
    }

    return dp[n];
};