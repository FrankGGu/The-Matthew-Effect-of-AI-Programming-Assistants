function countAlternatingSubarrays(nums) {
    let count = 0;
    let currentLength = 1;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] !== nums[i - 1]) {
            currentLength++;
        } else {
            currentLength = 1;
        }
        count += currentLength;
    }
    return count;
}