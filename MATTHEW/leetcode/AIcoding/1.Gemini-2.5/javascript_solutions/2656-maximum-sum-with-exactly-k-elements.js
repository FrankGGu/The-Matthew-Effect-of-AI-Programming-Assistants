var maximizeSum = function(nums, k) {
    let maxNum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    let totalSum = 0;
    for (let i = 0; i < k; i++) {
        totalSum += maxNum;
        maxNum++;
    }

    return totalSum;
};