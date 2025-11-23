function countInterestingSubarrays(nums, k) {
    let count = 0;
    let map = new Map();
    map.set(0, 1);
    let prefix = 0;

    for (let num of nums) {
        if (num % 2 === 1) {
            prefix++;
        }
        count += map.get(prefix - k) || 0;
        map.set(prefix, (map.get(prefix) || 0) + 1);
    }

    return count;
}