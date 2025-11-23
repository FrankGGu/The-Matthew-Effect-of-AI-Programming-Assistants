function longestSubarray(nums) {
    let max = Math.max(...nums);
    let maxLength = 0;
    let currentLength = 0;

    for (let num of nums) {
        if (num === max) {
            currentLength++;
            maxLength = Math.max(maxLength, currentLength);
        } else {
            currentLength = 0;
        }
    }

    return maxLength;
}