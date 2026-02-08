var minMaxGame = function(nums) {
    let n = nums.length;
    while (n > 1) {
        let newNums = [];
        for (let i = 0; i < n / 2; i++) {
            if (i % 2 === 0) {
                newNums.push(Math.min(nums[2 * i], nums[2 * i + 1]));
            } else {
                newNums.push(Math.max(nums[2 * i], nums[2 * i + 1]));
            }
        }
        nums = newNums;
        n = nums.length;
    }
    return nums[0];
};