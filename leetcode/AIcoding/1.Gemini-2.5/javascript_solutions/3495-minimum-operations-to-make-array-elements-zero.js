var minimumOperations = function(nums) {
    const distinctPositiveNumbers = new Set();
    for (const num of nums) {
        if (num > 0) {
            distinctPositiveNumbers.add(num);
        }
    }
    return distinctPositiveNumbers.size;
};