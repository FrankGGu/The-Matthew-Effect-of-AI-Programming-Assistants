var minOperations = function(nums, k) {
    const n = nums.length;
    const count = new Map();
    let operations = 0;

    for (let i = 0; i < n; i++) {
        count.set(nums[i], (count.get(nums[i]) || 0) + 1);
    }

    const target = Math.ceil(n / k);

    for (let freq of count.values()) {
        operations += Math.max(0, freq - target);
    }

    return operations;
};