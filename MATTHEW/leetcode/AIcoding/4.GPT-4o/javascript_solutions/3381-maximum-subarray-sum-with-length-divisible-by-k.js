function maxSumDivK(arr, k) {
    let n = arr.length;
    let maxSum = -Infinity;
    let sum = 0;
    let prefixSums = [0];

    for (let i = 0; i < n; i++) {
        sum += arr[i];
        if (i + 1 >= k) {
            maxSum = Math.max(maxSum, sum);
        }
        if (i + 1 >= k) {
            prefixSums.push(sum - (prefixSums[i + 1 - k] || 0));
        }
    }

    for (let i = 0; i < prefixSums.length; i++) {
        if (i >= k && prefixSums[i] % k === 0) {
            maxSum = Math.max(maxSum, prefixSums[i]);
        }
    }

    return maxSum;
}