var arrayChange = function(nums, operations) {
    const indexMap = new Map();
    for (let i = 0; i < nums.length; i++) {
        indexMap.set(nums[i], i);
    }
    for (const [oldValue, newValue] of operations) {
        if (indexMap.has(oldValue)) {
            const index = indexMap.get(oldValue);
            nums[index] = newValue;
            indexMap.delete(oldValue);
            indexMap.set(newValue, index);
        }
    }
    return nums;
};