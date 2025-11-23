function findKDistantIndices(nums, k) {
    const result = [];
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (Math.abs(i - j) <= k) {
                result.push(j);
            }
        }
    }
    return result;
}