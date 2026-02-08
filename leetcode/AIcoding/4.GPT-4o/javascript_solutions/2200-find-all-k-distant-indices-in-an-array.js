function findKDistantIndices(nums, key, k) {
    const result = [];
    const keyIndices = [];

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === key) {
            keyIndices.push(i);
        }
    }

    for (let i = 0; i < nums.length; i++) {
        for (let index of keyIndices) {
            if (Math.abs(index - i) <= k) {
                result.push(i);
                break;
            }
        }
    }

    return [...new Set(result)].sort((a, b) => a - b);
}