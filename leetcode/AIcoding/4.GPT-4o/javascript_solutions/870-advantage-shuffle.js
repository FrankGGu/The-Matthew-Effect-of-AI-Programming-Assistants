var advantageCount = function(A, B) {
    A.sort((a, b) => a - b);
    const n = A.length;
    const res = new Array(n);
    const bSorted = B.map((val, index) => [val, index]).sort((a, b) => a[0] - b[0]);
    let j = 0;

    for (let i = 0; i < n; i++) {
        if (A[i] > bSorted[j][0]) {
            res[bSorted[j][1]] = A[i];
            j++;
        } else {
            res[bSorted[n - 1 - (i - j)][1]] = A[i];
        }
    }

    return res;
};