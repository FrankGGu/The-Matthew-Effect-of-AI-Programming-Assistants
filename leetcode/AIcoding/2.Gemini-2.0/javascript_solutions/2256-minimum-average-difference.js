var minimumAverageDifference = function(nums) {
    const n = nums.length;
    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        totalSum += nums[i];
    }

    let minAvgDiff = Infinity;
    let minIndex = 0;
    let currentSum = 0;

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        let avg1 = Math.floor(currentSum / (i + 1));
        let avg2 = 0;
        if (i < n - 1) {
            avg2 = Math.floor((totalSum - currentSum) / (n - i - 1));
        }

        let diff = Math.abs(avg1 - avg2);

        if (diff < minAvgDiff) {
            minAvgDiff = diff;
            minIndex = i;
        }
    }

    return minIndex;
};