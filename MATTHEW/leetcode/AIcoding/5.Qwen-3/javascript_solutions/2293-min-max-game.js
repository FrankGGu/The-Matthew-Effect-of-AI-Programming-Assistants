function minMaxGame(nums) {
    while (nums.length > 1) {
        const newNums = [];
        for (let i = 0; i < nums.length; i += 2) {
            if (i + 1 < nums.length) {
                newNums.push(Math.min(nums[i], nums[i + 1]));
            } else {
                newNums.push(nums[i]);
            }
        }
        nums = newNums;
    }
    return nums[0];
}