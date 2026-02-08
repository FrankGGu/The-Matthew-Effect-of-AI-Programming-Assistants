var canAssign = function(nums, maxSize, maxSum) {
    const n = nums.length;
    if (n === 0) return true;

    nums.sort((a, b) => a - b);
    let groups = 0;
    let currentGroupSize = 0;
    let currentGroupSum = 0;

    for (let i = 0; i < n; i++) {
        if (currentGroupSize < maxSize && currentGroupSum + nums[i] <= maxSum) {
            currentGroupSize++;
            currentGroupSum += nums[i];
        } else {
            groups++;
            currentGroupSize = 1;
            currentGroupSum = nums[i];
            if (currentGroupSum > maxSum) return false;
        }
    }
    return groups + 1 <= maxSize;
};