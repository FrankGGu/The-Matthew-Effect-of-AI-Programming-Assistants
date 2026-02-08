var minOperations = function(nums) {
    let count = 0;
    for (let num of nums) {
        const remainder = num % 3;
        if (remainder === 1 || remainder === 2) {
            count += Math.min(remainder, 3 - remainder);
        }
    }
    return count;
};