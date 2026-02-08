var numOfPairs = function(nums, target) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j && nums[i] + nums[j] === target) {
                count++;
            }
        }
    }
    return count;
};