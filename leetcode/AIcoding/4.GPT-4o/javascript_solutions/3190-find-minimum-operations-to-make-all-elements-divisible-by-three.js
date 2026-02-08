var minOperations = function(nums) {
    let count = 0;
    for (let num of nums) {
        let remainder = num % 3;
        if (remainder === 1) {
            count += 2;
        } else if (remainder === 2) {
            count += 1;
        }
    }
    return count;
};