var countAlternatingSubarrays = function(nums) {
    let count = 0;
    let left = 0;
    for (let right = 0; right < nums.length; right++) {
        if (right > 0 && nums[right] === nums[right - 1]) {
            left = right;
        }
        count += right - left + 1;
    }
    return count;
};