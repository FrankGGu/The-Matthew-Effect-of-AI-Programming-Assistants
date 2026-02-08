var getMaxLen = function(nums) {
    let maxLen = 0, positiveLen = 0, negativeLen = 0;

    for (let num of nums) {
        if (num > 0) {
            positiveLen++;
            negativeLen = negativeLen > 0 ? negativeLen + 1 : 0;
        } else if (num < 0) {
            let temp = positiveLen;
            positiveLen = negativeLen > 0 ? negativeLen + 1 : 0;
            negativeLen = temp + 1;
        } else {
            positiveLen = 0;
            negativeLen = 0;
        }

        maxLen = Math.max(maxLen, positiveLen);
    }

    return maxLen;
};