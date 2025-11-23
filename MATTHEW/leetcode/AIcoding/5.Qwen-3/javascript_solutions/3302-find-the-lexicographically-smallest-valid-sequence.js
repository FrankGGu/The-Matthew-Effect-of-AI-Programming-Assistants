function findTheLongestSubsequenceII(target, words) {
    const MOD = 1000000007;
    const dp = new Array(target.length + 1).fill(0);
    dp[0] = 1;
    for (let i = 0; i < target.length; i++) {
        const count = new Array(26).fill(0);
        for (let j = 0; j < words.length; j++) {
            let idx = 0;
            while (idx < words[j].length && words[j][idx] !== target[i]) {
                idx++;
            }
            if (idx < words[j].length) {
                count[words[j][idx] - 'a'.charCodeAt(0)]++;
            }
        }
        for (let j = 0; j < 26; j++) {
            if (count[j] > 0) {
                dp[i + 1] = (dp[i + 1] + dp[i] * count[j]) % MOD;
            }
        }
    }
    return dp[target.length];
}