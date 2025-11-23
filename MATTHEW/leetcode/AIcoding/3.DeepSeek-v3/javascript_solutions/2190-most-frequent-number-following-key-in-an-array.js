var mostFrequent = function(nums, key) {
    const count = {};
    let maxCount = 0;
    let result = -1;

    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === key) {
            const target = nums[i + 1];
            count[target] = (count[target] || 0) + 1;
            if (count[target] > maxCount) {
                maxCount = count[target];
                result = target;
            }
        }
    }

    return result;
};