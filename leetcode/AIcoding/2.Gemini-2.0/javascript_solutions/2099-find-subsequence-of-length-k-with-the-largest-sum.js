var maxSubsequence = function(nums, k) {
    const n = nums.length;
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums[b] - nums[a]);
    const topKIndices = indices.slice(0, k).sort((a, b) => a - b);
    const result = [];
    for (let i = 0; i < k; i++) {
        result.push(nums[topKIndices[i]]);
    }
    return result;
};