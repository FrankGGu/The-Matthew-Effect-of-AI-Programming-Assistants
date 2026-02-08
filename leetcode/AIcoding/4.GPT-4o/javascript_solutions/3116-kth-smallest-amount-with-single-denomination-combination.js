function findKthSmallest(amounts, K) {
    const dp = Array(K + 1).fill(false);
    dp[0] = true;

    for (const amount of amounts) {
        for (let j = K; j >= amount; j--) {
            dp[j] = dp[j] || dp[j - amount];
        }
    }

    for (let i = 1; i <= K; i++) {
        if (dp[i]) {
            K--;
        }
        if (K === 0) {
            return i;
        }
    }

    return -1;
}