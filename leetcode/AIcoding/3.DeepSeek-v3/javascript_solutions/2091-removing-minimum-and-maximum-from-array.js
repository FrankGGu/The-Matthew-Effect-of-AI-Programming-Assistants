var minimumDeletions = function(nums) {
    if (nums.length <= 2) return nums.length;

    let minIndex = 0, maxIndex = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < nums[minIndex]) minIndex = i;
        if (nums[i] > nums[maxIndex]) maxIndex = i;
    }

    const left = Math.min(minIndex, maxIndex);
    const right = Math.max(minIndex, maxIndex);

    const option1 = right + 1;
    const option2 = nums.length - left;
    const option3 = (left + 1) + (nums.length - right);

    return Math.min(option1, option2, option3);
};