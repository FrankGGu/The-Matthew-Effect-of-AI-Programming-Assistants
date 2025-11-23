function partitionDisjoint(nums) {
    let max = nums[0];
    let prev = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < max) {
            prev = i;
        } else {
            max = nums[i];
        }
    }
    return prev;
}