var numOfSubarrays = function(arr, k, threshold) {
    let count = 0;
    let currentSum = 0;
    const targetSum = k * threshold;

    for (let i = 0; i < k; i++) {
        currentSum += arr[i];
    }

    if (currentSum >= targetSum) {
        count++;
    }

    for (let i = k; i < arr.length; i++) {
        currentSum += arr[i] - arr[i - k];
        if (currentSum >= targetSum) {
            count++;
        }
    }

    return count;
};