var largestSumOfAverages = function(A, K) {
    const N = A.length;
    const dp = Array.from({ length: N + 1 }, () => Array(K + 1).fill(0));
    const prefixSum = Array(N + 1).fill(0);

    for (let i = 1; i <= N; i++) {
        prefixSum[i] = prefixSum[i - 1] + A[i - 1];
    }

    const average = (start, end) => (prefixSum[end] - prefixSum[start]) / (end - start);

    for (let k = 1; k <= K; k++) {
        for (let i = k; i <= N; i++) {
            for (let j = k - 1; j < i; j++) {
                dp[i][k] = Math.max(dp[i][k], dp[j][k - 1] + average(j, i));
            }
        }
    }

    return dp[N][K];
};