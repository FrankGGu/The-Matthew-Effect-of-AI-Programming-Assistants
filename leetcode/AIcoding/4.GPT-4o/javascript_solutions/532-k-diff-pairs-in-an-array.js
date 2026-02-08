var findPairs = function(nums, k) {
    if (k < 0) return 0;
    const map = new Map();
    let count = 0;

    for (const num of nums) {
        map.set(num, (map.get(num) || 0) + 1);
    }

    for (const [num, freq] of map.entries()) {
        if (k === 0) {
            if (freq > 1) count++;
        } else if (map.has(num + k)) {
            count++;
        }
    }

    return count;
};