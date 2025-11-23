var minimumDeletions = function(nums) {
    let minIndex = 0, maxIndex = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < nums[minIndex]) minIndex = i;
        if (nums[i] > nums[maxIndex]) maxIndex = i;
    }
    let left = Math.min(minIndex, maxIndex) + 1;
    let right = Math.max(minIndex, maxIndex) + 1;
    let length = nums.length;
    return Math.min(length - left, right, left + (length - right));
};