var minOperations = function(nums) {
    let maxNum = Math.max(...nums);
    let operations = 0;

    for (let num of nums) {
        operations += maxNum - num;
    }

    return operations;
};