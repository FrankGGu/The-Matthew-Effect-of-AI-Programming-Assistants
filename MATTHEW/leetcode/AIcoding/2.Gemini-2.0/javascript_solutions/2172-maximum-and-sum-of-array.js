var maximumANDSum = function(nums, numSlots) {
    const n = nums.length;
    const m = numSlots;
    const dp = new Map();

    function solve(index, slots) {
        if (index === n) {
            return 0;
        }

        const key = `${index}-${slots}`;
        if (dp.has(key)) {
            return dp.get(key);
        }

        let maxScore = 0;
        for (let i = 1; i <= m; i++) {
            if ((slots & (1 << i)) > 0) {
                maxScore = Math.max(maxScore, (nums[index] & i) + solve(index + 1, slots ^ (1 << i)));
            }
        }

        dp.set(key, maxScore);
        return maxScore;
    }

    let initialSlots = 0;
    for (let i = 1; i <= m; i++) {
        initialSlots |= (1 << i) | (1 << i);
    }

    return solve(0, initialSlots);
};