var repeatedNTimes = function(A) {
    const set = new Set();
    for (let i = 0; i < A.length; i++) {
        if (set.has(A[i])) {
            return A[i];
        }
        set.add(A[i]);
    }
    return -1;
};