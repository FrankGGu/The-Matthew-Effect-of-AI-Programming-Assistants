var countSubarrays = function(nums) {
    let count = 0, max = Math.max(...nums);
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === max) {
            let j = i;
            while (j < nums.length && nums[j] === max) j++;
            let length = j - i;
            count += (length * (length + 1)) / 2; 
            i = j - 1;
        }
    }
    return count;
};