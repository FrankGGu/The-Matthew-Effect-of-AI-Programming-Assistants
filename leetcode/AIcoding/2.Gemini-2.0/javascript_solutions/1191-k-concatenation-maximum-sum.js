var kConcatenationMaxSum = function(arr, k) {
    const MOD = 10**9 + 7;

    function kadane(arr) {
        let maxSoFar = 0;
        let maxEndingHere = 0;
        for (let i = 0; i < arr.length; i++) {
            maxEndingHere = Math.max(0, maxEndingHere + arr[i]);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);
        }
        return maxSoFar;
    }

    let sum = arr.reduce((a, b) => a + b, 0);

    if (k === 1) {
        return kadane(arr) % MOD;
    }

    let maxPrefixSum = 0;
    let currentPrefixSum = 0;
    for (let i = 0; i < arr.length; i++) {
        currentPrefixSum += arr[i];
        maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
    }

    let maxSuffixSum = 0;
    let currentSuffixSum = 0;
    for (let i = arr.length - 1; i >= 0; i--) {
        currentSuffixSum += arr[i];
        maxSuffixSum = Math.max(maxSuffixSum, currentSuffixSum);
    }

    let result = 0;
    if (sum > 0) {
        result = Math.max(kadane(arr), maxPrefixSum + maxSuffixSum + (k - 2) * sum);
    } else {
        result = Math.max(kadane(arr), maxPrefixSum + maxSuffixSum);
    }

    return result % MOD;
};