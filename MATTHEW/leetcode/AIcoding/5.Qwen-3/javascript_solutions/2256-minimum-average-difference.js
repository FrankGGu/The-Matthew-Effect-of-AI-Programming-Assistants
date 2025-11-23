function minimumAverageDifference(nums) {
    const n = nums.length;
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }

    let leftSum = 0;
    let minDiff = Infinity;
    let resultIndex = 0;

    for (let i = 0; i < n; i++) {
        leftSum += nums[i];
        const rightSum = totalSum - leftSum;
        const leftAvg = leftSum / (i + 1);
        const rightAvg = i === n - 1 ? 0 : rightSum / (n - i - 1);
        const diff = Math.abs(leftAvg - rightAvg);

        if (diff < minDiff) {
            minDiff = diff;
            resultIndex = i;
        }
    }

    return resultIndex;
}