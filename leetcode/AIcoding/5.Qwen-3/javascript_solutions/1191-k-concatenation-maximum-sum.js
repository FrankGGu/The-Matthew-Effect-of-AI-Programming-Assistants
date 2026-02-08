function maxSubarraySum(arr, k) {
    let maxEndingHere = 0;
    let maxSoFar = 0;
    let total = 0;
    for (let i = 0; i < arr.length; i++) {
        maxEndingHere = Math.max(arr[i], maxEndingHere + arr[i]);
        maxSoFar = Math.max(maxSoFar, maxEndingHere);
        total += arr[i];
    }
    if (k === 1) return maxSoFar;
    let maxPrefix = -Infinity;
    let currentPrefix = 0;
    for (let i = 0; i < arr.length; i++) {
        currentPrefix += arr[i];
        maxPrefix = Math.max(maxPrefix, currentPrefix);
    }
    let maxSuffix = -Infinity;
    let currentSuffix = 0;
    for (let i = arr.length - 1; i >= 0; i--) {
        currentSuffix += arr[i];
        maxSuffix = Math.max(maxSuffix, currentSuffix);
    }
    return Math.max(maxSoFar, maxPrefix + maxSuffix + (k - 2) * total);
}

function maxSubarraySumKConcat(arr, k) {
    return maxSubarraySum(arr, k);
}