var kConcatenationMaxSum = function(arr, k) {
    const mod = 1e9 + 7;
    const n = arr.length;

    if (k === 1) {
        return maxSubArraySum(arr) % mod;
    }

    const totalSum = arr.reduce((a, b) => a + b, 0);
    const maxSum1 = maxSubArraySum(arr);
    const maxSum2 = maxSubArraySum(arr.concat(arr));

    if (totalSum > 0) {
        return Math.max(maxSum2, maxSum1 + totalSum * (k - 2)) % mod;
    }
    return Math.max(maxSum2, maxSum1) % mod;
};

function maxSubArraySum(arr) {
    let maxSoFar = -Infinity, maxEndingHere = 0;
    for (let num of arr) {
        maxEndingHere += num;
        maxSoFar = Math.max(maxSoFar, maxEndingHere);
        maxEndingHere = Math.max(maxEndingHere, 0);
    }
    return maxSoFar;
}