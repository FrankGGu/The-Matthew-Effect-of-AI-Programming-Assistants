var splitArraySameAverage = function(A) {
    const n = A.length;
    const sum = A.reduce((a, b) => a + b, 0);
    const dp = Array.from({ length: n + 1 }, () => new Set());
    dp[0].add(0);

    for (const num of A) {
        for (let i = n - 1; i >= 0; i--) {
            for (const s of dp[i]) {
                dp[i + 1].add(s + num);
            }
        }
    }

    for (let size = 1; size <= n / 2; size++) {
        if (sum * size % n === 0) {
            const target = sum * size / n;
            if (dp[size].has(target)) {
                return true;
            }
        }
    }
    return false;
};