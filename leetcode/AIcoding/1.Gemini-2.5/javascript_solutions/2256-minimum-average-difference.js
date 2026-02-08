var minimumAverageDifference = function(nums) {
    const n = nums.length;
    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        totalSum += nums[i];
    }

    let minAvgDiff = Infinity;
    let resultIndex = -1;

    let currentLeftSum = 0;

    for (let i = 0; i < n; i++) {
        currentLeftSum += nums[i];
        const leftCount = i + 1;
        const leftAvg = Math.floor(currentLeftSum / leftCount);

        const rightSum = totalSum - currentLeftSum;
        const rightCount = n - leftCount;

        let rightAvg = 0;
        if (rightCount > 0) {
            rightAvg = Math.floor(rightSum / rightCount);
        }

        const currentDiff = Math.abs(leftAvg - rightAvg);

        if (currentDiff < minAvgDiff) {
            minAvgDiff = currentDiff;
            resultIndex = i;
        }
    }

    return resultIndex;
};