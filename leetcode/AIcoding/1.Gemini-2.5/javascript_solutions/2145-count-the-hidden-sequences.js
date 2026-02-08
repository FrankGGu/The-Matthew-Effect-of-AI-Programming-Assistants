var countHiddenSequences = function(differences, lower, upper) {
    let minPrefixSum = 0;
    let maxPrefixSum = 0;
    let currentPrefixSum = 0;

    for (let i = 0; i < differences.length; i++) {
        currentPrefixSum += differences[i];
        minPrefixSum = Math.min(minPrefixSum, currentPrefixSum);
        maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
    }

    // Let the first element of the hidden sequence be `x`.
    // Then any element `a[k]` in the sequence is `x + prefixSum[k]`.
    // We need `lower <= x + prefixSum[k] <= upper` for all `k`.
    // This implies `lower - prefixSum[k] <= x <= upper - prefixSum[k]`.
    // To satisfy this for all `k`, `x` must be in the range:
    // `max(lower - prefixSum[k]) <= x <= min(upper - prefixSum[k])`
    // This simplifies to:
    // `lower - max(prefixSum[k]) <= x <= upper - min(prefixSum[k])`
    // So, `lowerBoundX = lower - maxPrefixSum`
    // And `upperBoundX = upper - minPrefixSum`

    let lowerBoundX = lower - maxPrefixSum;
    let upperBoundX = upper - minPrefixSum;

    // The number of integers `x` in the range [A, B] is `B - A + 1`.
    // If `A > B`, there are no integers, so the count is 0.
    let count = upperBoundX - lowerBoundX + 1;

    return Math.max(0, count);
};