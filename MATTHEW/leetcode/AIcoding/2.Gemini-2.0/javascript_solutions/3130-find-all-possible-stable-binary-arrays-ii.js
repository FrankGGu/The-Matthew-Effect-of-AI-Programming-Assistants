var findTheArrayConcVal = function(nums) {
    let sum = 0;
    let l = 0, r = nums.length - 1;
    while (l <= r) {
        if (l === r) {
            sum += nums[l];
        } else {
            sum += parseInt(nums[l].toString() + nums[r].toString());
        }
        l++;
        r--;
    }
    return sum;
};