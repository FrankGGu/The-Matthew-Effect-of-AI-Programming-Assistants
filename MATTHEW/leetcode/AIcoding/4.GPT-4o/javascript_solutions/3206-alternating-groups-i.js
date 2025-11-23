function alternatingGroups(A) {
    const result = [];
    const n = A.length;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            result.push(A[i]);
        }
    }

    for (let i = 0; i < n; i++) {
        if (i % 2 !== 0) {
            result.push(A[i]);
        }
    }

    return result;
}