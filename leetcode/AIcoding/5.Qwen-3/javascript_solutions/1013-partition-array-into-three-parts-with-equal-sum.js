var canPartition = function(nums) {
    const totalSum = nums.reduce((sum, num) => sum + num, 0);
    if (totalSum % 3 !== 0) return false;

    const target = totalSum / 3;
    let currentSum = 0;
    let count = 0;

    for (const num of nums) {
        currentSum += num;
        if (currentSum === target) {
            count++;
            currentSum = 0;
        }
    }

    return count >= 3;
};