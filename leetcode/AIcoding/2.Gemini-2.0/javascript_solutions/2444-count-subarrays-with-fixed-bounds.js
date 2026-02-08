var countSubarrays = function(nums, minK, maxK) {
    let count = 0;
    let minKIndex = -1;
    let maxKIndex = -1;
    let leftBound = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            leftBound = i;
            minKIndex = -1;
            maxKIndex = -1;
        }

        if (nums[i] === minK) {
            minKIndex = i;
        }

        if (nums[i] === maxK) {
            maxKIndex = i;
        }

        if (minKIndex !== -1 && maxKIndex !== -1) {
            count += Math.max(0, Math.min(minKIndex, maxKIndex) - leftBound);
        }
    }

    return count;
};