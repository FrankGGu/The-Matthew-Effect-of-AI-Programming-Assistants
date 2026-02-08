var countMonotonicPairs = function(A) {
    let count = 0;
    let n = A.length;

    for (let i = 1; i < n; i++) {
        if (A[i] >= A[i - 1]) {
            count++;
        }
    }

    return count;
};