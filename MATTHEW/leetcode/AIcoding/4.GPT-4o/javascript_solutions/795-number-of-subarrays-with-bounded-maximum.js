var numSubarrayBoundedMax = function(A, L, R) {
    let count = 0, start = -1, lastValid = -1;
    for (let i = 0; i < A.length; i++) {
        if (A[i] > R) {
            start = i;
        }
        if (A[i] >= L) {
            lastValid = i;
        }
        count += lastValid - start;
    }
    return count;
};