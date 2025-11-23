var minimumAverageDifference = function(nums) {
    const n = nums.length;
    let totalSum = nums.reduce((a, b) => a + b, 0);
    let minAvgDiff = Infinity;
    let index = -1;
    let prefixSum = 0;

    for (let i = 0; i < n; i++) {
        prefixSum += nums[i];
        let leftAvg = Math.floor(prefixSum / (i + 1));
        let rightAvg = i === n - 1 ? 0 : Math.floor((totalSum - prefixSum) / (n - i - 1));
        let avgDiff = Math.abs(leftAvg - rightAvg);

        if (avgDiff < minAvgDiff) {
            minAvgDiff = avgDiff;
            index = i;
        }
    }

    return index;
};