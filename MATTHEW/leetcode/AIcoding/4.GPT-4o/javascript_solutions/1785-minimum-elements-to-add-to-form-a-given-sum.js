function minElements(nums, limit, goal) {
    const currentSum = nums.reduce((a, b) => a + b, 0);
    const neededSum = goal - currentSum;
    const absNeededSum = Math.abs(neededSum);
    return Math.ceil(absNeededSum / limit);
}