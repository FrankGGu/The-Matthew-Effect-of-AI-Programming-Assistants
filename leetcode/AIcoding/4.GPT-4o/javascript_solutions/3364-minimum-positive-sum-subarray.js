function minPositiveSum(arr) {
    let minSum = Infinity;
    let currentSum = 0;
    let start = 0;

    for (let end = 0; end < arr.length; end++) {
        currentSum += arr[end];

        while (currentSum <= 0 && start <= end) {
            currentSum -= arr[start];
            start++;
        }

        if (currentSum > 0) {
            minSum = Math.min(minSum, currentSum);
        }
    }

    return minSum === Infinity ? 0 : minSum;
}