var minOperations = function(nums) {
    let flip = 0;
    let operations = 0;
    for (let i = 0; i < nums.length; i++) {
        if ((nums[i] + flip) % 2 === 0) {
            operations++;
            flip++;
        }
    }
    return operations;
};