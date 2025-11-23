function maxSubsequenceSum(nums, k) {
    const n = nums.length;
    const maxHeap = [];
    for (let i = 0; i < n; i++) {
        maxHeap.push([-nums[i], i]);
    }
    maxHeap.sort((a, b) => a[0] - b[0]);

    let sum = 0;
    const indices = new Set();
    for (let i = 0; i < k; i++) {
        const [val, idx] = maxHeap[i];
        sum += -val;
        indices.add(idx);
    }

    const sortedIndices = Array.from(indices).sort((a, b) => a - b);
    let result = 0;
    for (const idx of sortedIndices) {
        result += nums[idx];
    }

    return result;
}