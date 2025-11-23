var numberOfPoints = function(nums) {
    let points = new Set();
    for (let i = 0; i < nums.length; i++) {
        for (let j = nums[i][0]; j <= nums[i][1]; j++) {
            points.add(j);
        }
    }
    return points.size;
};