var numWays = function(words, target) {
    const mod = 10**9 + 7;
    const m = words[0].length;
    const n = target.length;
    const counts = Array(26).fill(null).map(() => Array(m).fill(0));

    for (let j = 0; j < m; j++) {
        for (const word of words) {
            counts[word.charCodeAt(j) - 'a'.charCodeAt(0)][j]++;
        }
    }

    const dp = Array(n + 1).fill(0);
    dp[0] = 1;

    for (let j = 0; j < m; j++) {
        for (let i = n - 1; i >= 0; i--) {
            dp[i + 1] = (dp[i + 1] + (dp[i] * counts[target.charCodeAt(i) - 'a'.charCodeAt(0)][j]) % mod) % mod;
        }
    }

    return dp[n];
};