var maxProduct = function(nums) {
    if (!nums || nums.length === 0) {
        return 0;
    }

    let maxSoFar = nums[0];
    let minSoFar = nums[0];
    let result = nums[0];

    for (let i = 1; i < nums.length; i++) {
        let curr = nums[i];
        let tempMax = Math.max(curr, Math.max(maxSoFar * curr, minSoFar * curr));
        minSoFar = Math.min(curr, Math.min(maxSoFar * curr, minSoFar * curr));
        maxSoFar = tempMax;
        result = Math.max(result, maxSoFar);
    }

    return result;
};