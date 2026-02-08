var triangularSum = function(nums) {
    let n = nums.length;
    while (n > 1) {
        let newNums = [];
        for (let i = 0; i < n - 1; i++) {
            newNums.push((nums[i] + nums[i + 1]) % 10);
        }
        nums = newNums;
        n--;
    }
    return nums[0];
};