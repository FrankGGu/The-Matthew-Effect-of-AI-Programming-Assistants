var tupleSameProduct = function(nums) {
    let count = 0;
    const n = nums.length;
    const map = new Map();

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const product = nums[i] * nums[j];
            map.set(product, (map.get(product) || 0) + 1);
        }
    }

    for (const value of map.values()) {
        count += value * (value - 1) * 4;
    }

    return count;
};