var longestSquareStreak = function(nums) {
    nums.sort((a, b) => a - b);
    const numSet = new Set(nums);

    let maxStreak = 1;

    for (let i = 0; i < nums.length; i++) {
        let currentNum = nums[i];
        let currentStreak = 1;

        while (numSet.has(currentNum * currentNum)) {
            currentNum *= currentNum;
            currentStreak++;
        }

        maxStreak = Math.max(maxStreak, currentStreak);
    }

    return maxStreak >= 2 ? maxStreak : -1;
};