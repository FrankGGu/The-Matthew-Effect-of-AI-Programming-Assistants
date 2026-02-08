var countSubarrays = function(nums, minK, maxK) {
    let count = 0, left = 0, minIndex = -1, maxIndex = -1;

    for (let right = 0; right < nums.length; right++) {
        if (nums[right] < minK || nums[right] > maxK) {
            left = right + 1;
            minIndex = -1;
            maxIndex = -1;
        }
        if (nums[right] === minK) minIndex = right;
        if (nums[right] === maxK) maxIndex = right;

        count += Math.max(0, Math.min(minIndex, maxIndex) - left + 1);
    }

    return count;
};