var lenLongestFibSubseq = function(A) {
    const n = A.length;
    const index = new Map();
    for (let i = 0; i < n; i++) {
        index.set(A[i], i);
    }

    const dp = new Array(n).fill(0).map(() => new Array(n).fill(2));
    let maxLen = 0;

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < j; i++) {
            const k = index.get(A[j] - A[i]);
            if (k !== undefined && k < i) {
                dp[i][j] = dp[k][i] + 1;
                maxLen = Math.max(maxLen, dp[i][j]);
            }
        }
    }

    return maxLen >= 3 ? maxLen : 0;
};