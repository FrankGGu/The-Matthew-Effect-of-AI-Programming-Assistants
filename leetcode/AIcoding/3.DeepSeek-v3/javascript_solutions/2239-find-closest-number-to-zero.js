var findClosestNumber = function(nums) {
    let closest = nums[0];
    for (let num of nums) {
        if (Math.abs(num) < Math.abs(closest)) {
            closest = num;
        } else if (Math.abs(num) === Math.abs(closest)) {
            closest = Math.max(closest, num);
        }
    }
    return closest;
};