var maximumSum = function(nums) {
    let maxSum = -Infinity;
    const freq = new Map();
    const prefixSum = new Array(nums.length + 1).fill(0);
    const suffixSum = new Array(nums.length + 1).fill(0);

    for (let i = 0; i < nums.length; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    for (let i = nums.length - 1; i >= 0; i--) {
        suffixSum[i] = suffixSum[i + 1] + nums[i];
    }

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (!freq.has(num)) {
            freq.set(num, []);
        }
        freq.get(num).push(i);
    }

    for (const [num, indices] of freq) {
        if (indices.length === 1) continue;
        let currentSum = 0;
        for (let i = 0; i < indices.length; i++) {
            const idx = indices[i];
            currentSum += nums[idx];
            if (i > 0) {
                const prevIdx = indices[i - 1];
                currentSum += prefixSum[idx] - prefixSum[prevIdx + 1];
            }
        }
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum === -Infinity ? Math.max(...nums) : maxSum;
};