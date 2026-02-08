function largestOutlier(nums) {
    if (nums.length === 0) return null;

    const mean = nums.reduce((a, b) => a + b, 0) / nums.length;
    let maxDiff = -Infinity;
    let result = nums[0];

    for (const num of nums) {
        const diff = Math.abs(num - mean);
        if (diff > maxDiff) {
            maxDiff = diff;
            result = num;
        } else if (diff === maxDiff && num > result) {
            result = num;
        }
    }

    return result;
}