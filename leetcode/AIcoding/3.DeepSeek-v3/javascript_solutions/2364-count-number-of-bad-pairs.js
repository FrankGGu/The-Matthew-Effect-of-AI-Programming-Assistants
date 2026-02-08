var countBadPairs = function(nums) {
    const n = nums.length;
    let total = n * (n - 1) / 2;
    const map = new Map();
    let good = 0;

    for (let i = 0; i < n; i++) {
        const key = i - nums[i];
        const count = map.get(key) || 0;
        good += count;
        map.set(key, count + 1);
    }

    return total - good;
};