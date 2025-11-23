var countInterestingSubarrays = function(nums, modulo, k) {
    let count = 0;
    let prefixSum = 0;
    const map = new Map();
    map.set(0, 1);

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % modulo === 0) {
            prefixSum = prefixSum;
        } else {
            prefixSum = (prefixSum + 1) % modulo;
        }

        const needed = (prefixSum - k + modulo) % modulo;

        if (map.has(needed)) {
            count += map.get(needed);
        }

        if (map.has(prefixSum)) {
            map.set(prefixSum, map.get(prefixSum) + 1);
        } else {
            map.set(prefixSum, 1);
        }
    }

    return count;
};