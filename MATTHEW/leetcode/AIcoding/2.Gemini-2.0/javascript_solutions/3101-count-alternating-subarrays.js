var countAlternatingSubarrays = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            let alternating = true;
            for (let k = i; k < j; k++) {
                if (nums[k] === nums[k + 1]) {
                    alternating = false;
                    break;
                }
            }
            if (alternating) {
                count++;
            }
        }
    }
    return count;
};