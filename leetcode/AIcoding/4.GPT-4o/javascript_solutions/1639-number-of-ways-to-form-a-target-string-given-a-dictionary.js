var numWays = function(words, target) {
    const MOD = 1e9 + 7;
    const m = words.length, n = words[0].length, t = target.length;
    const count = Array.from({ length: 26 }, () => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            count[words[i].charCodeAt(j) - 97][j]++;
        }
    }

    const dp = Array(t + 1).fill(0);
    dp[0] = 1;

    for (let i = 0; i < t; i++) {
        const charIndex = target.charCodeAt(i) - 97;
        for (let j = n - 1; j >= 0; j--) {
            dp[i + 1] = (dp[i + 1] + dp[i] * count[charIndex][j]) % MOD;
        }
    }

    return dp[t];
};