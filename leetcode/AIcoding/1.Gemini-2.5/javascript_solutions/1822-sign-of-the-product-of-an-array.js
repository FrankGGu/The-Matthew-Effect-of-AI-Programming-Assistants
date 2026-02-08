var arraySign = function(nums) {
    let sign = 1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            return 0;
        } else if (nums[i] < 0) {
            sign *= -1;
        }
    }

    return sign;
};