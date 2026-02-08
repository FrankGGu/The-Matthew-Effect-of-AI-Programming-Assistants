var minDifference = function(nums) {
    if (nums.length <= 4) return 0;
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let res = Infinity;
    for (let i = 0; i <= 3; i++) {
        res = Math.min(res, nums[n - 1 - (3 - i)] - nums[i]);
    }
    return res;
};