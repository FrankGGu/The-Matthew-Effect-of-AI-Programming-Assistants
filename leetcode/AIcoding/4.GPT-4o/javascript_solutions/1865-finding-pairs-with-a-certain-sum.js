var findPairs = function(nums, k) {
    if (k < 0) return 0;
    let count = 0;
    const map = new Map();

    for (const num of nums) {
        map.set(num, (map.get(num) || 0) + 1);
    }

    for (const [key, value] of map.entries()) {
        if (k === 0) {
            if (value > 1) count++;
        } else {
            if (map.has(key + k)) count++;
        }
    }

    return count;
};