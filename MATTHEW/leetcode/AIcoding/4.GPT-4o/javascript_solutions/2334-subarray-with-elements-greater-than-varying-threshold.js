var countSubarrays = function(nums, minK, maxK) {
    let count = 0, left = 0, validCount = 0;

    for (let right = 0; right < nums.length; right++) {
        if (nums[right] < minK || nums[right] > maxK) {
            left = right + 1;
            validCount = 0;
        } else {
            if (nums[right] === minK || nums[right] === maxK) {
                validCount++;
            }
            count += validCount;
            count += right - left + 1;
        }
    }

    return count;
};