var arithmeticTriplets = function(nums, diff) {
    const numSet = new Set(nums);
    let count = 0;

    for (const num of nums) {
        if (numSet.has(num + diff) && numSet.has(num + 2 * diff)) {
            count++;
        }
    }

    return count;
};