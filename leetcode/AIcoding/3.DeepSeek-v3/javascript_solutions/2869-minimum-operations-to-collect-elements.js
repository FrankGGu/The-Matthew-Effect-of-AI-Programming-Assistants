var minOperations = function(nums, k) {
    const needed = new Set();
    for (let i = 1; i <= k; i++) {
        needed.add(i);
    }
    let operations = 0;
    for (let i = nums.length - 1; i >= 0; i--) {
        if (needed.has(nums[i])) {
            needed.delete(nums[i]);
        }
        operations++;
        if (needed.size === 0) {
            break;
        }
    }
    return operations;
};