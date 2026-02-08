var returnToBoundaryCount = function(nums) {
    let currentPosition = 0;
    let boundaryCrossings = 0;

    for (let i = 0; i < nums.length; i++) {
        currentPosition += nums[i];
        if (currentPosition === 0) {
            boundaryCrossings++;
        }
    }

    return boundaryCrossings;
};