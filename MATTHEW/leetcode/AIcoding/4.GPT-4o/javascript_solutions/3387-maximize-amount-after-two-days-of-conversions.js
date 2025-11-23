function maximizeAmount(A) {
    let n = A.length;
    if (n < 3) return 0;

    let maxAmount = 0;
    for (let i = 0; i < n - 2; i++) {
        for (let j = i + 1; j < n - 1; j++) {
            for (let k = j + 1; k < n; k++) {
                maxAmount = Math.max(maxAmount, A[i] + A[j] + A[k]);
            }
        }
    }
    return maxAmount;
}