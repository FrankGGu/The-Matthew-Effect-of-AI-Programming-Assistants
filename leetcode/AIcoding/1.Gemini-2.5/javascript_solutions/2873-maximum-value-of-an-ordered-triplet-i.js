var maximumTripletValue = function(nums) {
    let maxVal = 0;
    const n = nums.length;

    for (let i = 0; i < n - 2; i++) {
        for (let j = i + 1; j < n - 1; j++) {
            for (let k = j + 1; k < n; k++) {
                const currentVal = (nums[i] - nums[j]) * nums[k];
                if (currentVal > maxVal) {
                    maxVal = currentVal;
                }
            }
        }
    }

    return maxVal;
};