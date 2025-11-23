var targetIndices = function(nums, target) {
    nums.sort((a, b) => a - b);
    let indices = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === target) {
            indices.push(i);
        }
    }
    return indices;
};