var minOperations = function(nums, k) {
    let xorSum = 0;
    for (let num of nums) {
        xorSum ^= num;
    }

    let xorResult = xorSum ^ k;
    let operations = 0;

    while (xorResult > 0) {
        if (xorResult % 2 === 1) {
            operations++;
        }
        xorResult = Math.floor(xorResult / 2);
    }

    return operations;
};