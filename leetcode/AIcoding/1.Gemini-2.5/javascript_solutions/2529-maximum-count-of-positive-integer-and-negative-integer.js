var maximumCount = function(nums) {
    let negCount = 0;
    let posCount = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < 0) {
            negCount++;
        } else if (nums[i] > 0) {
            posCount++;
        }
    }

    return Math.max(negCount, posCount);
};