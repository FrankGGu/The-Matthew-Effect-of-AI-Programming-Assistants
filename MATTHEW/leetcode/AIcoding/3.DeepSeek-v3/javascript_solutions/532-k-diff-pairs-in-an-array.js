var findPairs = function(nums, k) {
    const map = new Map();
    const result = new Set();

    for (let i = 0; i < nums.length; i++) {
        if (map.has(nums[i] - k)) {
            result.add(`${nums[i] - k},${nums[i]}`);
        }
        if (map.has(nums[i] + k)) {
            result.add(`${nums[i]},${nums[i] + k}`);
        }
        map.set(nums[i], (map.get(nums[i]) || 0) + 1);
    }

    return result.size;
};