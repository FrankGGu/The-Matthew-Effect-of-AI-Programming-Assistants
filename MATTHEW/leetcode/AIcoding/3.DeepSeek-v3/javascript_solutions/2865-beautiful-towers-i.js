var maximumSumOfHeights = function(maxHeights) {
    let maxSum = 0;
    const n = maxHeights.length;

    for (let peak = 0; peak < n; peak++) {
        let sum = maxHeights[peak];
        let prev = maxHeights[peak];

        for (let i = peak - 1; i >= 0; i--) {
            prev = Math.min(prev, maxHeights[i]);
            sum += prev;
        }

        prev = maxHeights[peak];
        for (let i = peak + 1; i < n; i++) {
            prev = Math.min(prev, maxHeights[i]);
            sum += prev;
        }

        maxSum = Math.max(maxSum, sum);
    }

    return maxSum;
};