var longestSquareStreak = function(nums) {
    nums.sort((a, b) => a - b);
    const set = new Set(nums);
    let maxStreak = 0;

    for (const num of nums) {
        let currentStreak = 1;
        let currentNum = num;

        while (set.has(currentNum * currentNum)) {
            currentStreak++;
            currentNum = currentNum * currentNum;
        }

        maxStreak = Math.max(maxStreak, currentStreak);
    }

    return maxStreak > 1 ? maxStreak : -1;
};