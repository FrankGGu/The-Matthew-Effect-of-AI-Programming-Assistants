var longestNiceSubarray = function(nums) {
    let left = 0;
    let current_OR = 0;
    let maxLength = 0;

    for (let right = 0; right < nums.length; right++) {
        let num = nums[right];

        while ((current_OR & num) !== 0) {
            current_OR ^= nums[left];
            left++;
        }

        current_OR |= num;

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};