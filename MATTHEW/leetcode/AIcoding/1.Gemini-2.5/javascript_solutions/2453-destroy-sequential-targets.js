var destroyTargets = function(nums, space) {
    nums.sort((a, b) => a - b);

    const remainderCounts = new Map();

    for (const num of nums) {
        const remainder = num % space;
        remainderCounts.set(remainder, (remainderCounts.get(remainder) || 0) + 1);
    }

    let maxDestroyedCount = 0;
    let minTarget = -1; 

    for (const num of nums) {
        const remainder = num % space;
        const currentCount = remainderCounts.get(remainder);

        if (currentCount > maxDestroyedCount) {
            maxDestroyedCount = currentCount;
            minTarget = num;
        }
    }

    return minTarget;
};