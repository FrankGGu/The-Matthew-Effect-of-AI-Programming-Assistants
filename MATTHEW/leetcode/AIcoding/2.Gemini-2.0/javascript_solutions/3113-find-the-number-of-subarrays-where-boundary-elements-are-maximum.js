var countSubarrays = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i; j < nums.length; j++) {
            let maxVal = Math.max(nums[i], nums[j]);
            if (nums[i] === maxVal && nums[j] === maxVal) {
                let subarray = nums.slice(i, j + 1);
                let maxInSubarray = Math.max(...subarray);
                if (nums[i] === maxInSubarray) {
                    count++;
                }
            }
        }
    }
    return count;
};