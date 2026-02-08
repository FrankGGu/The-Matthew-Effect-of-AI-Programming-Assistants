var arrayChange = function(nums, operations) {
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        map.set(nums[i], i);
    }

    for (const [val, replacement] of operations) {
        const index = map.get(val);
        nums[index] = replacement;
        map.delete(val);
        map.set(replacement, index);
    }

    return nums;
};