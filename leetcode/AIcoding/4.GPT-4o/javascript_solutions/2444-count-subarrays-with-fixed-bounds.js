var countSubarrays = function(nums, minK, maxK) {
    let count = 0;
    let minCount = 0, maxCount = 0, lastInvalid = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            lastInvalid = i;
            minCount = 0;
            maxCount = 0;
        } else {
            if (nums[i] === minK) minCount++;
            if (nums[i] === maxK) maxCount++;
            count += Math.min(minCount, maxCount);
        }
    }

    return count;
};