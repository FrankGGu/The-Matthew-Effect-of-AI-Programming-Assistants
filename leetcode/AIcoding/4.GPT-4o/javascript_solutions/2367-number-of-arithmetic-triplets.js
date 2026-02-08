var countArithmeticTriplets = function(nums, diff) {
    let count = 0;
    const numSet = new Set(nums);

    for (let num of nums) {
        if (numSet.has(num + diff) && numSet.has(num + 2 * diff)) {
            count++;
        }
    }

    return count;
};