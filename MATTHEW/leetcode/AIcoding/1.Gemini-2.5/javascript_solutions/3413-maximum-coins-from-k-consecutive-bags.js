var putMarbles = function(weights, k) {
    const n = weights.length;

    if (k === 1 || k === n) {
        return 0;
    }

    const diffs = new Array(n - 1);
    for (let i = 0; i < n - 1; i++) {
        diffs[i] = weights[i] + weights[i+1];
    }

    diffs.sort((a, b) => a - b);

    let minSum = 0;
    for (let i = 0; i < k - 1; i++) {
        minSum += diffs[i];
    }

    let maxSum = 0;
    for (let i = 0; i < k - 1; i++) {
        maxSum += diffs[n - 2 - i];
    }

    return maxSum - minSum;
};