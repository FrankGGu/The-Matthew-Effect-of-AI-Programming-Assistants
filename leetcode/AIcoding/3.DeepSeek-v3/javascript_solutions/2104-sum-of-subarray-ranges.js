var subArrayRanges = function(nums) {
    let sum = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let minVal = nums[i];
        let maxVal = nums[i];
        for (let j = i + 1; j < n; j++) {
            minVal = Math.min(minVal, nums[j]);
            maxVal = Math.max(maxVal, nums[j]);
            sum += maxVal - minVal;
        }
    }

    return sum;
};