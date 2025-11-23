var minLengthAfterRemovals = function(nums) {
    const n = nums.length;
    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    let maxCount = 0;
    for (const c of count.values()) {
        maxCount = Math.max(maxCount, c);
    }

    if (maxCount <= Math.floor(n / 2)) {
        return n % 2;
    } else {
        return 2 * maxCount - n;
    }
};