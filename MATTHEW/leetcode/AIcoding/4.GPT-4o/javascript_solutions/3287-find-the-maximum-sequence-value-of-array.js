function maxSequenceValue(arr) {
    if (arr.length === 0) return 0;
    let maxSum = 0;
    let currentSum = 0;

    for (let i = 0; i < arr.length; i++) {
        currentSum += arr[i];
        if (currentSum < 0) currentSum = 0;
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
}