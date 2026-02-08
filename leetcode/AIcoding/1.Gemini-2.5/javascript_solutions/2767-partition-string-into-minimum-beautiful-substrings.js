var minimumBeautifulSubstrings = function(s) {
    if (s[0] === '0') {
        return -1;
    }

    const powersOfFiveBinary = new Set([
        "1", // 5^0
        "101", // 5^1
        "11001", // 5^2
        "1111101", // 5^3
        "1001110001", // 5^4
        "110000011101", // 5^5
        "11110011010001" // 5^6
    ]);

    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[n] = 0;

    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === '0') {
            continue;
        }

        for (let j = i; j < n; j++) {
            const sub = s.substring(i, j + 1);
            if (powersOfFiveBinary.has(sub)) {
                if (dp[j + 1] !== Infinity) {
                    dp[i] = Math.min(dp[i], 1 + dp[j + 1]);
                }
            }
        }
    }

    return dp[0] === Infinity ? -1 : dp[0];
};