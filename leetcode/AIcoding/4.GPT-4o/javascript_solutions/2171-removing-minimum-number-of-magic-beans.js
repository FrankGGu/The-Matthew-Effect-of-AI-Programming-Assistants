var minRemoval = function(A) {
    A.sort((a, b) => a - b);
    let total = 0, n = A.length;
    for (let i = 0; i < n; i++) {
        total += A[i];
    }
    let prefixSum = 0, minRemovals = Infinity;
    for (let i = 0; i < n; i++) {
        prefixSum += A[i];
        minRemovals = Math.min(minRemovals, total - prefixSum - (n - i - 1) * A[i]);
    }
    return minRemovals;
};