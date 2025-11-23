var minSubarray = function(nums, p) {
    const totalSum = nums.reduce((sum, num) => (sum + num) % p, 0);
    if (totalSum === 0) return 0;

    let minLen = Infinity;
    let prefixSum = 0;
    const prefixMap = new Map();
    prefixMap.set(0, -1);

    for (let i = 0; i < nums.length; i++) {
        prefixSum = (prefixSum + nums[i]) % p;
        const target = (prefixSum - totalSum + p) % p;

        if (prefixMap.has(target)) {
            minLen = Math.min(minLen, i - prefixMap.get(target));
        }
        prefixMap.set(prefixSum, i);
    }

    return minLen < nums.length ? minLen : -1;
};