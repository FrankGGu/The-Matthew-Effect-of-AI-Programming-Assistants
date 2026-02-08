var isStraight = function(nums) {
    nums.sort((a, b) => a - b);

    let jokerCount = 0;
    for (let i = 0; i < 5; i++) {
        if (nums[i] === 0) {
            jokerCount++;
        } else if (i > 0 && nums[i] === nums[i - 1] && nums[i - 1] !== 0) {
            return false;
        }
    }

    return nums[4] - nums[jokerCount] < 5;
};