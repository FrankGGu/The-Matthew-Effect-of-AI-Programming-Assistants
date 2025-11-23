var numMoves = function(a, b, c) {
    let nums = [a, b, c].sort((x, y) => x - y);
    if (nums[2] - nums[1] === 1 && nums[1] - nums[0] === 1) return 0;
    if (nums[2] - nums[1] === 2 || nums[1] - nums[0] === 2) return 1;
    return Math.min(nums[1] - nums[0] - 1, nums[2] - nums[1] - 1);
};