var findKDistantIndices = function(nums, key, k) {
    const n = nums.length;
    const keyIndices = [];
    for (let i = 0; i < n; i++) {
        if (nums[i] === key) {
            keyIndices.push(i);
        }
    }

    const resultIndices = new Set();
    for (const i of keyIndices) {
        const start = Math.max(0, i - k);
        const end = Math.min(n - 1, i + k);
        for (let j = start; j <= end; j++) {
            resultIndices.add(j);
        }
    }

    const sortedResult = Array.from(resultIndices);
    sortedResult.sort((a, b) => a - b);

    return sortedResult;
};