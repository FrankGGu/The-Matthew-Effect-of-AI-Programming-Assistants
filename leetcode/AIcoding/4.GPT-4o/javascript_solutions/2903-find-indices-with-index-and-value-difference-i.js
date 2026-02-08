var findIndices = function(nums) {
    let result = [];
    for (let i = 0; i < nums.length; i++) {
        if (i === nums[i]) {
            result.push(i);
        }
    }
    return result;
};