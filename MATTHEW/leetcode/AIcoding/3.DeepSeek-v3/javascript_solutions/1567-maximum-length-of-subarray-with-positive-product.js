var getMaxLen = function(nums) {
    let maxLen = 0;
    let posLen = 0, negLen = 0;

    for (let num of nums) {
        if (num === 0) {
            posLen = 0;
            negLen = 0;
        } else if (num > 0) {
            posLen++;
            negLen = negLen === 0 ? 0 : negLen + 1;
        } else {
            let temp = posLen;
            posLen = negLen === 0 ? 0 : negLen + 1;
            negLen = temp + 1;
        }
        maxLen = Math.max(maxLen, posLen);
    }

    return maxLen;
};