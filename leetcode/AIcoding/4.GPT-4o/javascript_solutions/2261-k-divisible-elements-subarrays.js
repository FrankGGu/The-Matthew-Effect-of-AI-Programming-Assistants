function countKDivisibleSubarrays(nums, k) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const modCount = new Map();
    let count = 0;

    for (let i = 0; i <= n; i++) {
        const mod = ((prefixSum[i] % k) + k) % k;
        if (modCount.has(mod)) {
            count += modCount.get(mod);
        }
        modCount.set(mod, (modCount.get(mod) || 0) + 1);
    }

    return count;
}