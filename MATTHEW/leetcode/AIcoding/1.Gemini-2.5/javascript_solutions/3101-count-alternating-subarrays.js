var countAlternatingSubarrays = function(nums) {
    let count = 0;
    let currentLength = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        if (i === 0 || (nums[i] % 2) !== (nums[i-1] % 2)) {
            currentLength++;
        } else {
            currentLength = 1;
        }
        count += currentLength;
    }

    return count;
};