var reductionOperations = function(nums) {
    nums.sort((a, b) => a - b);
    let count = 0;
    let op = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) {
            count++;
        }
        op += count;
    }
    return op;
};