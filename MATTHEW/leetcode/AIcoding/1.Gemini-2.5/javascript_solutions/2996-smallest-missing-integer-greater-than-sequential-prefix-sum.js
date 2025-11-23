var smallestMissingInteger = function(nums) {
    let currentSum = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] === nums[i - 1] + 1) {
            currentSum += nums[i];
        } else {
            break;
        }
    }

    const numSet = new Set(nums);

    let missing = currentSum + 1;
    while (numSet.has(missing)) {
        missing++;
    }

    return missing;
};