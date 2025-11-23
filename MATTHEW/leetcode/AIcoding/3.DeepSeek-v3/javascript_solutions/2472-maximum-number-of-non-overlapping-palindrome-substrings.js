var maxPalindromes = function(s, k) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    const isPalindrome = (l, r) => {
        while (l < r) {
            if (s[l] !== s[r]) return false;
            l++;
            r--;
        }
        return true;
    };

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (let j = i - k; j >= 0; j--) {
            if (isPalindrome(j, i - 1)) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
                break;
            }
        }
    }
    return dp[n];
};