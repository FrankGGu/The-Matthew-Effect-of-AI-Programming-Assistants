var minOperations = function(nums) {
    let maxVal = 0, operations = 0;
    for (let num of nums) {
        if (num > 0) {
            maxVal = Math.max(maxVal, num);
            operations += Math.floor(Math.log2(num));
        }
    }
    return operations + maxVal;
};