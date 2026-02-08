var maxRotateFunction = function(A) {
    const n = A.length;
    let F = 0, totalSum = 0;

    for (let i = 0; i < n; i++) {
        F += i * A[i];
        totalSum += A[i];
    }

    let maxF = F;

    for (let i = 1; i < n; i++) {
        F = F + totalSum - n * A[n - i];
        maxF = Math.max(maxF, F);
    }

    return maxF;
};