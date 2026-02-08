var beautifulSubarrays = function(nums) {
    let count = 0;
    let xor = 0;
    const map = new Map();
    map.set(0, 1);

    for (let num of nums) {
        xor ^= num;
        if (map.has(xor)) {
            count += map.get(xor);
            map.set(xor, map.get(xor) + 1);
        } else {
            map.set(xor, 1);
        }
    }

    return count;
};