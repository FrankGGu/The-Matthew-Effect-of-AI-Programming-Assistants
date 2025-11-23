function putMarbles(weights, k) {
    if (k === 1 || weights.length === 1) return 0;

    const n = weights.length;
    const dp = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1] + weights[i];
    }

    const sorted = [...dp].sort((a, b) => b - a);

    let result = 0;
    for (let i = 0; i < k - 1; i++) {
        result += sorted[i];
    }

    return result;
}