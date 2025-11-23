var countInterestingSubarrays = function(nums, modulo, k) {
    const n = nums.length;
    let prefix = 0;
    const count = new Map();
    count.set(0, 1);
    let res = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] % modulo === k) {
            prefix++;
        }
        const key = prefix % modulo;
        const target = (key - k + modulo) % modulo;
        res += count.get(target) || 0;
        count.set(key, (count.get(key) || 0) + 1);
    }

    return res;
};