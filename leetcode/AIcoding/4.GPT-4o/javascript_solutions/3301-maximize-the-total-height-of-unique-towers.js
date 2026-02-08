function maxHeight(A) {
    A.sort((a, b) => b - a);
    let dp = new Array(A.length + 1).fill(0);

    for (let i = 0; i < A.length; i++) {
        for (let j = i; j >= 0; j--) {
            dp[j + 1] = Math.max(dp[j + 1], dp[j] + A[i]);
        }
    }

    return Math.max(...dp);
}