var arithmeticTriplets = function(nums, diff) {
    let count = 0;
    const set = new Set(nums);
    for (const num of nums) {
        if (set.has(num + diff) && set.has(num + 2 * diff)) {
            count++;
        }
    }
    return count;
};