var maximumSumOfHeights = function(maxHeights) {
    let n = maxHeights.length;
    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        let currentSum = 0;
        let currentHeight = maxHeights[i];

        currentSum += currentHeight;

        for (let j = i - 1; j >= 0; j--) {
            currentHeight = Math.min(currentHeight, maxHeights[j]);
            currentSum += currentHeight;
        }

        currentHeight = maxHeights[i];

        for (let j = i + 1; j < n; j++) {
            currentHeight = Math.min(currentHeight, maxHeights[j]);
            currentSum += currentHeight;
        }

        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};