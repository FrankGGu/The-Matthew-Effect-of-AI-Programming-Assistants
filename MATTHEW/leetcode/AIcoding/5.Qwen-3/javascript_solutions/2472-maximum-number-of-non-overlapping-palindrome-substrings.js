function maxNumOfNonOverlappingPalindromes(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    const isPalindrome = new Array(n).fill().map(() => new Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
        for (let j = i + 1; j < n; j++) {
            if (s[i] === s[j]) {
                if (j - i === 1 || isPalindrome[i + 1][j - 1]) {
                    isPalindrome[i][j] = true;
                }
            }
        }
    }

    for (let i = 0; i < n; i++) {
        dp[i + 1] = dp[i];
        for (let j = 0; j <= i; j++) {
            if (isPalindrome[j][i]) {
                dp[i + 1] = Math.max(dp[i + 1], dp[j] + 1);
            }
        }
    }

    return dp[n];
}