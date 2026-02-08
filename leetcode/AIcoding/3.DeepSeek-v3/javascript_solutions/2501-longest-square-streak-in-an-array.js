var longestSquareStreak = function(nums) {
    const numSet = new Set(nums);
    let maxStreak = 0;

    for (const num of nums) {
        let currentNum = num;
        let currentStreak = 1;

        while (numSet.has(currentNum * currentNum)) {
            currentNum *= currentNum;
            currentStreak++;
        }

        if (currentStreak > maxStreak) {
            maxStreak = currentStreak;
        }
    }

    return maxStreak >= 2 ? maxStreak : -1;
};