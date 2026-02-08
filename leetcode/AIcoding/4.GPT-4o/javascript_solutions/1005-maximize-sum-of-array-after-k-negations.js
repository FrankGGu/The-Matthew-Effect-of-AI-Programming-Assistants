var largestSumAfterKNegations = function(A, K) {
    A.sort((a, b) => a - b);
    for (let i = 0; i < K; i++) {
        A[0] = -A[0];
        A.sort((a, b) => a - b);
    }
    return A.reduce((sum, num) => sum + num, 0);
};