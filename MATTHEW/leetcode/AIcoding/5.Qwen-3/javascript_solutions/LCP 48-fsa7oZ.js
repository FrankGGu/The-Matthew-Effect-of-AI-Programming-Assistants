function minMovesToEqualArrayElements(nums) {
    nums.sort((a, b) => a - b);
    let moves = 0;
    for (let i = 1; i < nums.length; i++) {
        moves += nums[i] - nums[0];
    }
    return moves;
}