var minimumOperations = function(nums) {
    const uniquePositiveNumbers = new Set();

    for (const num of nums) {
        if (num > 0) {
            uniquePositiveNumbers.add(num);
        }
    }

    return uniquePositiveNumbers.size;
};