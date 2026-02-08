function countPairs(nums) {
    const map = new Map();
    const n = nums.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const product = nums[i] * nums[j];
            if (map.has(product)) {
                count += map.get(product);
            }
            map.set(product, (map.get(product) || 0) + 1);
        }
    }

    return count;
}