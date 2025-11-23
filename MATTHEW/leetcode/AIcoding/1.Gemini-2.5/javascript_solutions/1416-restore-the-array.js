var restoreTheArray = function(s, k) {
    const MOD = 10**9 + 7;
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    dp[n] = 1;

    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === '0') {
            dp[i] = 0;
            continue;
        }

        let currentNum = 0;
        for (let j = i; j < n; j++) {
            const digit = parseInt(s[j]);

            // Check for potential overflow before multiplication, although for k up to 10^9,
            // currentNum * 10 + digit will fit in a standard JS number (up to 9 * 10^15).
            // The check currentNum > k will prevent it from growing too large.
            currentNum = currentNum * 10 + digit;

            if (currentNum > k) {
                break;
            }

            dp[i] = (dp[i] + dp[j + 1]) % MOD;
        }
    }

    return dp[0];
};