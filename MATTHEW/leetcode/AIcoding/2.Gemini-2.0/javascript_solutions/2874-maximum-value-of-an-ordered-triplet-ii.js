var maximumTripletValue = function(nums) {
    let n = nums.length;
    let maxVal = 0;
    let maxPrefix = new Array(n).fill(0);
    let maxSuffix = new Array(n).fill(0);

    maxPrefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        maxPrefix[i] = Math.max(maxPrefix[i - 1], nums[i]);
    }

    maxSuffix[n - 1] = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        maxSuffix[i] = Math.max(maxSuffix[i + 1], nums[i]);
    }

    for (let j = 1; j < n - 1; j++) {
        maxVal = Math.max(maxVal, (maxPrefix[j - 1] - nums[j]) * maxSuffix[j + 1]);
    }

    return maxVal;
};