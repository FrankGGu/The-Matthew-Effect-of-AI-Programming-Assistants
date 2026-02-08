function hasTrailingZeros(nums) {
    const orResult = nums.reduce((acc, num) => acc | num, 0);
    return (orResult & -orResult) === orResult;
}