var minimumSum = function(nums) {
    let minSum = Infinity;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                if (nums[i] < nums[j] && nums[k] < nums[j]) {
                    const currentSum = nums[i] + nums[j] + nums[k];
                    if (currentSum < minSum) {
                        minSum = currentSum;
                    }
                }
            }
        }
    }

    return minSum === Infinity ? -1 : minSum;
};