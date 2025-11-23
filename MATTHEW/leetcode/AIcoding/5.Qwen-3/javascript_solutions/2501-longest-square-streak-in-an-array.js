function longestSquareStreak(nums) {
    const numSet = new Set(nums);
    let maxLength = 0;
    const visited = new Set();

    for (const num of nums) {
        if (visited.has(num)) continue;
        let current = num;
        let length = 0;
        while (numSet.has(current)) {
            visited.add(current);
            length++;
            current = current * current;
        }
        maxLength = Math.max(maxLength, length);
    }

    return maxLength >= 2 ? maxLength : -1;
}