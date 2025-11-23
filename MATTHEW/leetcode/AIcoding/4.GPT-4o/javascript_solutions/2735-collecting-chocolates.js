function maxChocolates(A, B, C) {
    A.sort((a, b) => a - b);
    B.sort((a, b) => a - b);
    C.sort((a, b) => a - b);

    let totalChocolates = 0;
    let i = 0, j = 0, k = 0;

    while (i < A.length && j < B.length && k < C.length) {
        if (A[i] === B[j] && B[j] === C[k]) {
            totalChocolates += A[i];
            i++;
            j++;
            k++;
        } else {
            const minValue = Math.min(A[i], B[j], C[k]);
            if (A[i] === minValue) i++;
            else if (B[j] === minValue) j++;
            else k++;
        }
    }

    return totalChocolates;
}