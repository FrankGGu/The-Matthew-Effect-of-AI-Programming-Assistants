var minimumRemovals = function(A) {
    const n = A.length;
    const lis = new Array(n).fill(1);
    const lds = new Array(n).fill(1);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (A[i] > A[j]) {
                lis[i] = Math.max(lis[i], lis[j] + 1);
            }
        }
    }

    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j > i; j--) {
            if (A[i] > A[j]) {
                lds[i] = Math.max(lds[i], lds[j] + 1);
            }
        }
    }

    let maxLen = 0;
    for (let i = 0; i < n; i++) {
        if (lis[i] > 1 && lds[i] > 1) {
            maxLen = Math.max(maxLen, lis[i] + lds[i] - 1);
        }
    }

    return n - maxLen;
};