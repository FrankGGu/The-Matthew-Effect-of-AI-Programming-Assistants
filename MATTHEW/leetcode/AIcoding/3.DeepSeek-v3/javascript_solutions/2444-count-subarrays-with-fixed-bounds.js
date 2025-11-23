var countSubarrays = function(nums, minK, maxK) {
    let res = 0;
    let minPos = -1, maxPos = -1, leftBound = -1;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            leftBound = i;
        }
        if (nums[i] === minK) {
            minPos = i;
        }
        if (nums[i] === maxK) {
            maxPos = i;
        }
        res += Math.max(0, Math.min(minPos, maxPos) - leftBound);
    }
    return res;
};