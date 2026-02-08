var largestSumAfterKNegations = function(nums, k) {
    nums.sort((a, b) => a - b);

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < 0 && k > 0) {
            nums[i] = -nums[i];
            k--;
        } else if (nums[i] >= 0) {
            break;
        }
    }

    if (k % 2 === 1) {
        let minAbsValue = Infinity;
        let minAbsIndex = -1;
        for (let i = 0; i < nums.length; i++) {
            if (Math.abs(nums[i]) < minAbsValue) {
                minAbsValue = Math.abs(nums[i]);
                minAbsIndex = i;
            }
        }
        nums[minAbsIndex] = -nums[minAbsIndex];
    }

    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
    }

    return sum;
};