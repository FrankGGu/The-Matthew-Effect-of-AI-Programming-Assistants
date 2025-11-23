var maxNonDecreasingLength = function(A, B) {
    let n = A.length;
    let maxLength = 0;

    let dpA = new Array(n).fill(1);
    let dpB = new Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        if (A[i] >= A[i - 1]) {
            dpA[i] = dpA[i - 1] + 1;
        }
        if (B[i] >= B[i - 1]) {
            dpB[i] = dpB[i - 1] + 1;
        }

        if (A[i] >= B[i - 1]) {
            dpA[i] = Math.max(dpA[i], dpB[i - 1] + 1);
        }
        if (B[i] >= A[i - 1]) {
            dpB[i] = Math.max(dpB[i], dpA[i - 1] + 1);
        }

        maxLength = Math.max(maxLength, dpA[i], dpB[i]);
    }

    return maxLength;
};