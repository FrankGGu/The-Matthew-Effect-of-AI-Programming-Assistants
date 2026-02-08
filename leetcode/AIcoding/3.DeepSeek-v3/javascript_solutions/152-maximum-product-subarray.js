var maxProduct = function(nums) {
    if (nums.length === 0) return 0;

    let maxSoFar = nums[0];
    let minSoFar = nums[0];
    let result = maxSoFar;

    for (let i = 1; i < nums.length; i++) {
        const current = nums[i];
        const tempMax = Math.max(current, Math.max(maxSoFar * current, minSoFar * current));
        minSoFar = Math.min(current, Math.min(maxSoFar * current, minSoFar * current));

        maxSoFar = tempMax;

        result = Math.max(result, maxSoFar);
    }

    return result;
};