var movementOfRobots = function(nums, d) {
    const finalPositions = [];
    for (let i = 0; i < nums.length; i++) {
        finalPositions.push(nums[i] + d);
    }
    finalPositions.sort((a, b) => a - b);
    return finalPositions;
};