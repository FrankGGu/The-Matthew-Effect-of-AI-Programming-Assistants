var getMinDistance = function(nums, target, start) {
    let minDistance = Infinity;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === target) {
            const distance = Math.abs(i - start);
            if (distance < minDistance) {
                minDistance = distance;
            }
        }
    }
    return minDistance;
};