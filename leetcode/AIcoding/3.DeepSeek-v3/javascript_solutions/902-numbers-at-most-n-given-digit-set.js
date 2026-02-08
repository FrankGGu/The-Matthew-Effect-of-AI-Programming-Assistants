var atMostNGivenDigitSet = function(digits, n) {
    const s = n.toString();
    const k = s.length;
    const dp = new Array(k + 1).fill(0);
    dp[k] = 1;

    for (let i = k - 1; i >= 0; --i) {
        const si = s[i];
        for (const d of digits) {
            if (d < si) {
                dp[i] += Math.pow(digits.length, k - i - 1);
            } else if (d === si) {
                dp[i] += dp[i + 1];
            }
        }
    }

    for (let i = 1; i < k; ++i) {
        dp[0] += Math.pow(digits.length, i);
    }

    return dp[0];
};