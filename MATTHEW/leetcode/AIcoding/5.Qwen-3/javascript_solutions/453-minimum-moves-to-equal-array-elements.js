function minMoves(nums) {
    let min = nums[0];
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        if (nums[i] < min) {
            min = nums[i];
        }
    }
    return sum - min * nums.length;
}