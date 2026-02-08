var beautifulSubarrays = function(nums) {
    const prefixXor = new Map();
    prefixXor.set(0, 1);
    let res = 0;
    let currentXor = 0;

    for (const num of nums) {
        currentXor ^= num;
        if (prefixXor.has(currentXor)) {
            res += prefixXor.get(currentXor);
            prefixXor.set(currentXor, prefixXor.get(currentXor) + 1);
        } else {
            prefixXor.set(currentXor, 1);
        }
    }

    return res;
};