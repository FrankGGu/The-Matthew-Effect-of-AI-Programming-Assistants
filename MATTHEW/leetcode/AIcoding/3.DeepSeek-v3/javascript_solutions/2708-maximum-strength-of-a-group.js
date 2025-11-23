var maxStrength = function(nums) {
    let maxStrength = nums[0];
    let minStrength = nums[0];
    let result = nums[0];

    for (let i = 1; i < nums.length; i++) {
        const num = nums[i];
        const tempMax = maxStrength;
        maxStrength = Math.max(num, maxStrength * num, minStrength * num);
        minStrength = Math.min(num, tempMax * num, minStrength * num);
        result = Math.max(result, maxStrength);
    }

    return result;
};