var smallestRangeII = function(A, k) {
    A.sort((a, b) => a - b);
    const n = A.length;
    if (n === 1) {
        return 0;
    }

    let ans = A[n - 1] - A[0];

    for (let i = 0; i < n - 1; i++) {
        const minVal = Math.min(A[0] + k, A[i + 1] - k);
        const maxVal = Math.max(A[i] + k, A[n - 1] - k);
        ans = Math.min(ans, maxVal - minVal);
    }

    return ans;
};