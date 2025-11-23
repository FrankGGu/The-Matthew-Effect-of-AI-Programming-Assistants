function destroyTargets(nums, target) {
    let minLength = Infinity;
    let count = 0;

    for (const num of nums) {
        if (num % target === 0) {
            count++;
            minLength = Math.min(minLength, num);
        }
    }

    return count === 0 ? -1 : minLength;
}