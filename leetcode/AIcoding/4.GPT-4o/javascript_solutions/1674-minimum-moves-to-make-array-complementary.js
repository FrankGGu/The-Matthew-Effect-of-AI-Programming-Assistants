function minMoves(nums) {
    const n = nums.length;
    const total = nums.reduce((sum, num) => sum + num, 0);
    const min = Math.min(...nums);
    return (n * min - total) + (n - 1);
}