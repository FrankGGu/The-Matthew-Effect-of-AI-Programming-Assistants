function beautifulIndices(nums, k) {
    const n = nums.length;
    const result = [];
    const indices = [];

    for (let i = 0; i < n; i++) {
        indices.push(i);
    }

    indices.sort((a, b) => nums[a] - nums[b]);

    let j = 0;
    for (let i = 0; i < n; i++) {
        while (j < n && Math.abs(indices[j] - indices[i]) <= k) {
            j++;
        }
        if (j > i + 1) {
            result.push(indices[i]);
        }
    }

    return result;
}