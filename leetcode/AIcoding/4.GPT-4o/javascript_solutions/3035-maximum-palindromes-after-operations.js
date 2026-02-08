var maximumPalindromes = function(s, k) {
    let n = s.length;
    let dp = new Array(n + 1).fill(0);
    let count = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            dp[i + 1] = dp[i] + 1;
        } else {
            dp[i + 1] = dp[i];
        }
    }

    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            count++;
        }
    }

    let maxPalindromes = Math.floor(count / 2);

    for (let i = 0; i < n; i++) {
        if (s[i] === '0' && dp[i + 1] >= k) {
            maxPalindromes++;
        }
    }

    return Math.min(maxPalindromes, n / 2);
};