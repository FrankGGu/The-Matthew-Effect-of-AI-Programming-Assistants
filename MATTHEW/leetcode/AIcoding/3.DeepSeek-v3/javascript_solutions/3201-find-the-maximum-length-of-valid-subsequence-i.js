var maximumLength = function(nums) {
    let maxLen = 0;
    let currentLen = 0;
    let prev = -Infinity;

    for (const num of nums) {
        if (num > prev) {
            currentLen++;
            maxLen = Math.max(maxLen, currentLen);
        } else {
            currentLen = 1;
        }
        prev = num;
    }

    return maxLen;
};