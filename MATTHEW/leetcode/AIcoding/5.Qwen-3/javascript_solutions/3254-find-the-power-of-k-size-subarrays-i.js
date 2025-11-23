function resultsArray(nums, k) {
    const n = nums.length;
    const result = [];
    for (let i = 0; i <= n - k; i++) {
        let max = nums[i];
        for (let j = i + 1; j < i + k; j++) {
            max = Math.max(max, nums[j]);
        }
        result.push(max);
    }
    return result;
}