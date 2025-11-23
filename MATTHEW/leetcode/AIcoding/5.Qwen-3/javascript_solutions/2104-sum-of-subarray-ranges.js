function sumSubarrayRanges(nums) {
    const n = nums.length;
    let result = 0;
    for (let i = 0; i < n; i++) {
        let minVal = nums[i];
        let maxVal = nums[i];
        for (let j = i + 1; j < n; j++) {
            minVal = Math.min(minVal, nums[j]);
            maxVal = Math.max(maxVal, nums[j]);
            result += maxVal - minVal;
        }
    }
    return result;
}