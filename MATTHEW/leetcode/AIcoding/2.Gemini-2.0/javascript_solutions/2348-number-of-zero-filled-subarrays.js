var zeroFilledSubarray = function(nums) {
    let count = 0;
    let len = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            len++;
        } else {
            count += (len * (len + 1)) / 2;
            len = 0;
        }
    }
    count += (len * (len + 1)) / 2;
    return count;
};