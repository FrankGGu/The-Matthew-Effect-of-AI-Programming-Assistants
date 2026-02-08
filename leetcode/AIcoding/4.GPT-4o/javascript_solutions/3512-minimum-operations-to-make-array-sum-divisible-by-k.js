function minOperations(nums, k) {
    const sum = nums.reduce((a, b) => a + b, 0);
    const remainder = sum % k;
    if (remainder === 0) return 0;

    const n = nums.length;
    let minOps = Infinity;
    let currentSum = 0;
    const prefixSums = new Map();

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        const target = (currentSum - remainder + k) % k;

        if (currentSum % k === remainder) {
            minOps = Math.min(minOps, i + 1);
        }

        if (prefixSums.has(target)) {
            minOps = Math.min(minOps, i - prefixSums.get(target));
        }

        if (!prefixSums.has(currentSum % k)) {
            prefixSums.set(currentSum % k, i);
        }
    }

    return minOps === Infinity ? -1 : minOps;
}