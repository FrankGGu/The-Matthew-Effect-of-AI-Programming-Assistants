var closestToZero = function(nums) {
    let closest = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (Math.abs(nums[i]) < Math.abs(closest)) {
            closest = nums[i];
        } else if (Math.abs(nums[i]) === Math.abs(closest) && nums[i] > closest) {
            closest = nums[i];
        }
    }
    return closest;
};