var maxSequenceValue = function(nums) {
    let max = -Infinity;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i; j < nums.length; j++) {
            let min = Infinity;
            let sum = 0;
            for (let k = i; k <= j; k++) {
                sum += nums[k];
                if (nums[k] < min) {
                    min = nums[k];
                }
            }
            let current = min * sum;
            if (current > max) {
                max = current;
            }
        }
    }
    return max;
};