var getMaxLen = function(nums) {
    let maxLen = 0;
    let posLen = 0;
    let negLen = 0;

    for (let num of nums) {
        if (num === 0) {
            posLen = 0;
            negLen = 0;
        } else if (num > 0) {
            posLen++;
            negLen = negLen > 0 ? negLen + 1 : 0;
        } else {
            let temp = posLen;
            posLen = negLen > 0 ? negLen + 1 : 0;
            negLen = temp + 1;
        }
        maxLen = Math.max(maxLen, posLen);
    }

    return maxLen;
};