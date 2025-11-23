var maxSubarrays = function(nums) {
    let minAnd = nums[0];
    for (let num of nums) {
        minAnd &= num;
    }
    if (minAnd !== 0) {
        return 1;
    }
    let res = 0;
    let currentAnd = ~0;
    for (let num of nums) {
        currentAnd &= num;
        if (currentAnd === 0) {
            res++;
            currentAnd = ~0;
        }
    }
    return res;
};