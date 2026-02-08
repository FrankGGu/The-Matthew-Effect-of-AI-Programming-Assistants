var minIncrementForUnique = function(nums) {
    nums.sort((a, b) => a - b);

    let totalSum = 0;
    let expected = 0; // The minimum value the current number should be

    for (let i = 0; i < nums.length; i++) {
        let currentNum = nums[i];
        if (currentNum < expected) {
            // If the current number is less than what's expected,
            // we must increment it to 'expected'.
            totalSum += expected;
            expected++; // The next number must be at least 'expected + 1'
        } else {
            // If the current number is already greater than or equal to what's expected,
            // it can be used as is.
            totalSum += currentNum;
            expected = currentNum + 1; // The next number must be at least 'currentNum + 1'
        }
    }

    return totalSum;
};