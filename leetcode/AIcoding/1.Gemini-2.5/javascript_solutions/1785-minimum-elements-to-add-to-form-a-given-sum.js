var minElements = function(nums, limit, goal) {
    let currentSum = 0;
    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
    }

    const difference = goal - currentSum;
    const absDifference = Math.abs(difference);

    return Math.ceil(absDifference / limit);
};