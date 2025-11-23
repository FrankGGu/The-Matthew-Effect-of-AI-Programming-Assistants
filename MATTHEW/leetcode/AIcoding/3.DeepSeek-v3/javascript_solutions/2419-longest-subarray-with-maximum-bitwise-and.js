var longestSubarray = function(nums) {
    let maxAnd = 0;
    let maxLen = 0;
    let currentLen = 0;
    let currentMax = 0;

    for (let num of nums) {
        if (num > currentMax) {
            currentMax = num;
            currentLen = 1;
        } else if (num === currentMax) {
            currentLen++;
        } else {
            currentMax = 0;
            currentLen = 0;
        }

        if (currentMax > maxAnd) {
            maxAnd = currentMax;
            maxLen = currentLen;
        } else if (currentMax === maxAnd) {
            if (currentLen > maxLen) {
                maxLen = currentLen;
            }
        }
    }

    return maxLen;
};