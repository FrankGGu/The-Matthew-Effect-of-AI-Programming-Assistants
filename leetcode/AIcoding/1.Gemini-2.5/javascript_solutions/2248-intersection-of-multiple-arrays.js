var intersection = function(nums) {
    const counts = new Map();
    const n = nums.length;

    for (const arr of nums) {
        const uniqueElements = new Set(arr);
        for (const num of uniqueElements) {
            counts.set(num, (counts.get(num) || 0) + 1);
        }
    }

    const result = [];
    for (const [num, count] of counts.entries()) {
        if (count === n) {
            result.push(num);
        }
    }

    result.sort((a, b) => a - b);

    return result;
};