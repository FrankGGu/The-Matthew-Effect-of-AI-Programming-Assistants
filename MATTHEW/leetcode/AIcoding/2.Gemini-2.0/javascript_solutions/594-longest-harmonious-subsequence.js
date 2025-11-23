var findLHS = function(nums) {
    let map = new Map();
    for (let num of nums) {
        map.set(num, (map.get(num) || 0) + 1);
    }
    let maxLen = 0;
    for (let num of map.keys()) {
        if (map.has(num + 1)) {
            maxLen = Math.max(maxLen, map.get(num) + map.get(num + 1));
        }
    }
    return maxLen;
};