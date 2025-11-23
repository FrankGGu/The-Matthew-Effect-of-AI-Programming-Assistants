var antOnTheBoundary = function(nums) {
    let count = 0;
    let position = 0;
    for (let i = 0; i < nums.length; i++) {
        position += nums[i];
        if (position === 0) {
            count++;
        }
    }
    return count;
};