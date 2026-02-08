var smallestRangeI = function(A, K) {
    let minVal = A[0];
    let maxVal = A[0];

    for (let i = 1; i < A.length; i++) {
        minVal = Math.min(minVal, A[i]);
        maxVal = Math.max(maxVal, A[i]);
    }

    return Math.max(0, maxVal - minVal - 2 * K);
};