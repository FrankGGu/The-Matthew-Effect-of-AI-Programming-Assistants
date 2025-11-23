var minimumSum = function(A) {
    let n = A.length;
    let prefix = new Array(n).fill(0);
    let suffix = new Array(n).fill(0);

    prefix[0] = A[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = Math.min(prefix[i - 1], A[i]);
    }

    suffix[n - 1] = A[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        suffix[i] = Math.min(suffix[i + 1], A[i]);
    }

    let minSum = Infinity;
    for (let i = 1; i < n - 1; i++) {
        minSum = Math.min(minSum, prefix[i - 1] + A[i] + suffix[i + 1]);
    }

    return minSum;
};