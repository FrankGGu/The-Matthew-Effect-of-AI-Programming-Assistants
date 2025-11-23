var maxSumTwoNoOverlap = function(A, L, M) {
    const n = A.length;
    let maxL = 0, maxM = 0, sumL = 0, sumM = 0;

    for (let i = 0; i < n; i++) {
        if (i < L) sumL += A[i];
        else if (i < L + M) sumM += A[i];
        else {
            maxL = Math.max(maxL, sumL);
            sumM += A[i];
            sumL += A[i - M];
        }
        if (i >= L) sumL += A[i - L];
        if (i >= M) sumM += A[i - M];
    }

    let result = 0;

    for (let i = 0; i <= n - L; i++) {
        let sum1 = 0;
        for (let j = i; j < i + L; j++) sum1 += A[j];
        result = Math.max(result, sum1 + maxM);
        if (i + L < n) maxM = Math.max(maxM, A[i + L]);
    }

    maxL = 0;
    for (let i = 0; i <= n - M; i++) {
        let sum1 = 0;
        for (let j = i; j < i + M; j++) sum1 += A[j];
        result = Math.max(result, sum1 + maxL);
        if (i + M < n) maxL = Math.max(maxL, A[i + M]);
    }

    return result;
};