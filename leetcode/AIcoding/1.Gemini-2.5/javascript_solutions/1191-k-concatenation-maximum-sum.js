var kConcatenationMaxSum = function(arr, k) {
    const MOD = 10**9 + 7;

    // Calculate max subarray sum for a single array (Kadane's algorithm)
    let maxSubarraySumOnce = arr[0];
    let currentMax = arr[0];
    for (let i = 1; i < arr.length; i++) {
        currentMax = Math.max(arr[i], currentMax + arr[i]);
        maxSubarraySumOnce = Math.max(maxSubarraySumOnce, currentMax);
    }

    // Calculate total sum of the array
    let totalSum = 0;
    for (let i = 0; i < arr.length; i++) {
        totalSum += arr[i];
    }

    // Calculate maximum prefix sum
    let maxPrefixSum = -Infinity;
    let currentPrefixSum = 0;
    for (let i = 0; i < arr.length; i++) {
        currentPrefixSum += arr[i];
        maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
    }

    // Calculate maximum suffix sum
    let maxSuffixSum = -Infinity;
    let currentSuffixSum = 0;
    for (let i = arr.length - 1; i >= 0; i--) {
        currentSuffixSum += arr[i];
        maxSuffixSum = Math.max(maxSuffixSum, currentSuffixSum);
    }

    let result = maxSubarraySumOnce;

    if (k === 1) {
        // Result is simply the max subarray sum of the single array
    } else {
        // Case 1: Subarray spans two blocks (suffix of first arr + prefix of second arr)
        // This covers cases like [..., suffix | prefix, ...]
        result = Math.max(result, maxPrefixSum + maxSuffixSum);

        // Case 2: Subarray spans more than two blocks, and totalSum is positive.
        // This means we can add (k-2) full copies of arr in between the suffix and prefix.
        // e.g., [..., suffix | arr | arr | ... | arr | prefix, ...]
        if (totalSum > 0) {
            result = Math.max(result, maxPrefixSum + (k - 2) * totalSum + maxSuffixSum);
        }
    }

    // Ensure the result is non-negative before applying modulo
    // (result % MOD + MOD) % MOD handles negative results correctly
    return (result % MOD + MOD) % MOD;
};