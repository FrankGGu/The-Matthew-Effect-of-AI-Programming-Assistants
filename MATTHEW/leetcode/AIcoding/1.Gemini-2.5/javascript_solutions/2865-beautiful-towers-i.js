var maximumSumOfHeights = function(maxHeights) {
    const n = maxHeights.length;
    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        let currentSum = 0;
        let currentPeakHeight = maxHeights[i];
        currentSum += currentPeakHeight;

        let leftHeight = currentPeakHeight;
        for (let j = i - 1; j >= 0; j--) {
            leftHeight = Math.min(leftHeight, maxHeights[j]);
            currentSum += leftHeight;
        }

        let rightHeight = currentPeakHeight;
        for (let j = i + 1; j < n; j++) {
            rightHeight = Math.min(rightHeight, maxHeights[j]);
            currentSum += rightHeight;
        }

        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};