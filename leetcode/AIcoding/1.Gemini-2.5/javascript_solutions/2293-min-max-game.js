var minMaxGame = function(nums) {
    if (nums.length === 1) {
        return nums[0];
    }

    let n = nums.length;

    while (n > 1) {
        let newNums = new Array(n / 2);
        for (let i = 0; i < n / 2; i++) {
            if (i % 2 === 0) {
                newNums[i] = Math.min(nums[2 * i], nums[2 * i + 1]);
            } else {
                newNums[i] = Math.max(nums[2 * i], nums[2 * i + 1]);
            }
        }
        nums = newNums;
        n = n / 2;
    }

    return nums[0];
};