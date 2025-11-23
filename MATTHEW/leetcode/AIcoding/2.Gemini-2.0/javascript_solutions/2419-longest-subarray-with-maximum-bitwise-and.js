var longestSubarray = function(nums) {
    let maxVal = 0;
    for (let num of nums) {
        maxVal = Math.max(maxVal, num);
    }

    let maxLen = 0;
    let currLen = 0;

    for (let num of nums) {
        if (num === maxVal) {
            currLen++;
            maxLen = Math.max(maxLen, currLen);
        } else {
            currLen = 0;
        }
    }

    return maxLen;
};