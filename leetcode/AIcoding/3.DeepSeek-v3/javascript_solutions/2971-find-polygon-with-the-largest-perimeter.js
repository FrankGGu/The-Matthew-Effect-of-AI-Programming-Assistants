var largestPerimeter = function(nums) {
    nums.sort((a, b) => a - b);
    let sum = 0;
    let res = -1;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < sum) {
            res = sum + nums[i];
        }
        sum += nums[i];
    }
    return res;
};