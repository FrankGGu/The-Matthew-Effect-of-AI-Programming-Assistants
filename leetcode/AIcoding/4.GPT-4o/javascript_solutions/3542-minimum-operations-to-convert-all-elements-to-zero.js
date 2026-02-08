var minimumOperations = function(nums) {
    const uniqueNonZero = new Set();
    for (const num of nums) {
        if (num > 0) {
            uniqueNonZero.add(num);
        }
    }
    return uniqueNonZero.size;
};