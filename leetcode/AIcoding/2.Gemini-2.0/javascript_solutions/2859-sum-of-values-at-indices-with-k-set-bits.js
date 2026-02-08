var sumIndicesWithKSetBits = function(nums, k) {
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        let count = 0;
        let num = i;
        while (num > 0) {
            num &= (num - 1);
            count++;
        }
        if (count === k) {
            sum += nums[i];
        }
    }
    return sum;
};