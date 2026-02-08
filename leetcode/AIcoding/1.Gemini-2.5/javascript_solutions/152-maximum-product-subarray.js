var maxProduct = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    let maxSoFar = nums[0];
    let currentMax = nums[0];
    let currentMin = nums[0];

    for (let i = 1; i < nums.length; i++) {
        let num = nums[i];

        let tempCurrentMax = currentMax;

        currentMax = Math.max(num, tempCurrentMax * num, currentMin * num);
        currentMin = Math.min(num, tempCurrentMax * num, currentMin * num);

        maxSoFar = Math.max(maxSoFar, currentMax);
    }

    return maxSoFar;
};