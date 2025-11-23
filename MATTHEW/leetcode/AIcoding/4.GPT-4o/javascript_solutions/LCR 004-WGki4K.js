var singleNumber = function(nums) {
    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }
    for (const [key, value] of count) {
        if (value === 1) return key;
    }
};