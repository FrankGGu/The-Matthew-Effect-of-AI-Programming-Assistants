var minimumAverageDifference = function(nums) {
    let n = nums.length;
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }

    let leftSum = 0;
    let minDiff = Infinity;
    let result = 0;

    for (let i = 0; i < n; i++) {
        leftSum += nums[i];
        let leftAvg = Math.floor(leftSum / (i + 1));
        let rightSum = totalSum - leftSum;
        let rightAvg = i === n - 1 ? 0 : Math.floor(rightSum / (n - i - 1));
        let diff = Math.abs(leftAvg - rightAvg);

        if (diff < minDiff) {
            minDiff = diff;
            result = i;
        }
    }

    return result;
};