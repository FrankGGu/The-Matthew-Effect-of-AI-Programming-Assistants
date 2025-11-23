function flowerGame(A, B) {
    let n = A.length;
    let dp = Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i + 1] = dp[i] + A[i];
    }

    let total = dp[n];
    let maxAlice = 0;

    for (let i = 0; i < n; i++) {
        maxAlice = Math.max(maxAlice, dp[i + 1] - (total - dp[i + 1]));
    }

    return maxAlice;
}