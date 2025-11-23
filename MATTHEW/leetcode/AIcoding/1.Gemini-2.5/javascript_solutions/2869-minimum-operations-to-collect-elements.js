var minOperations = function(nums, k) {
    const collected = new Set();
    let operations = 0;

    for (let i = nums.length - 1; i >= 0; i--) {
        operations++;
        const num = nums[i];

        if (num >= 1 && num <= k) {
            collected.add(num);
        }

        if (collected.size === k) {
            return operations;
        }
    }

    return operations;
};