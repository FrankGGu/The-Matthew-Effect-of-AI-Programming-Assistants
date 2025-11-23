var countBadPairs = function(nums) {
    let n = nums.length;
    let totalPairs = (n * (n - 1)) / 2;
    let goodPairs = 0;
    let map = new Map();

    for (let i = 0; i < n; i++) {
        let diff = nums[i] - i;
        if (map.has(diff)) {
            goodPairs += map.get(diff);
            map.set(diff, map.get(diff) + 1);
        } else {
            map.set(diff, 1);
        }
    }

    return totalPairs - goodPairs;
};