var countSubarrays = function(nums, k) {
    let maxVal = Math.max(...nums);
    let count = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        let maxCount = 0;
        for (let j = i; j < n; j++) {
            if (nums[j] === maxVal) {
                maxCount++;
            }
            if (maxCount >= k) {
                count++;
            }
        }
    }

    return count;
};