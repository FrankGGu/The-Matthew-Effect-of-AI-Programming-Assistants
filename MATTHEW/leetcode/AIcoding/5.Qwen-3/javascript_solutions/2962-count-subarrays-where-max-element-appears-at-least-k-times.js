function countSubarrays(nums, k) {
    const maxVal = Math.max(...nums);
    let count = 0;
    let left = 0;
    let maxCount = 0;

    for (let right = 0; right < nums.length; right++) {
        if (nums[right] === maxVal) {
            maxCount++;
        }

        while (maxCount >= k) {
            count += nums.length - right;
            if (nums[left] === maxVal) {
                maxCount--;
            }
            left++;
        }
    }

    return count;
}