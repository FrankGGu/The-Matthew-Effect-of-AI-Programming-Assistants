function minSubarray(nums, p) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    const targetRemainder = totalSum % p;
    if (targetRemainder === 0) return 0;

    const n = nums.length;
    const prefixSum = new Map();
    prefixSum.set(0, -1);
    let currentSum = 0;
    let minLength = Infinity;

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        const mod = ((currentSum % p) + p) % p;
        const neededMod = (mod - targetRemainder + p) % p;

        if (prefixSum.has(neededMod)) {
            minLength = Math.min(minLength, i - prefixSum.get(neededMod));
        }
        prefixSum.set(mod, i);
    }

    return minLength === Infinity ? -1 : minLength;
}