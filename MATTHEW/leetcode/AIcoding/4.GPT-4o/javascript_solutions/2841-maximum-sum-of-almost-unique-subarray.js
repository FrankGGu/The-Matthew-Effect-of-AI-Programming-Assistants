var maximumSum = function(arr) {
    let maxSum = arr[0];
    let currentSum = arr[0];
    let seen = new Set();

    for (let i = 1; i < arr.length; i++) {
        if (seen.has(arr[i])) {
            currentSum = 0;
            seen.clear();
        }
        currentSum += arr[i];
        seen.add(arr[i]);
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};