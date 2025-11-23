var maxSubarrays = function(nums) {
    let minAnd = nums[0];
    for (let num of nums) {
        minAnd &= num;
    }

    let currentAnd = (1 << 30) - 1;
    let count = 0;
    for (let num of nums) {
        currentAnd &= num;
        if (currentAnd === minAnd) {
            count++;
            currentAnd = (1 << 30) - 1;
        }
    }
    return Math.max(1, count);
};