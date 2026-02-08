function longestSquareStreak(nums) {
    const numSet = new Set(nums);
    let longestStreak = 0;

    for (let num of nums) {
        let currentStreak = 0;
        let squareNum = num * num;

        while (numSet.has(squareNum)) {
            currentStreak++;
            squareNum *= squareNum; // move to the next square
        }

        longestStreak = Math.max(longestStreak, currentStreak);
    }

    return longestStreak > 1 ? longestStreak : -1;
}