var subarraySum = function(nums, k) {
    const map = new Map();
    map.set(0, 1);
    let sum = 0;
    let count = 0;
    for (const num of nums) {
        sum += num;
        if (map.has(sum - k)) {
            count += map.get(sum - k);
        }
        map.set(sum, (map.get(sum) || 0) + 1);
    }
    return count;
};