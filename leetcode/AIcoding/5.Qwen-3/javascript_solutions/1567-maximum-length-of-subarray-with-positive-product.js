function findMaxLength(nums) {
    let maxLen = 0;
    let positive = 0;
    let negative = 0;

    for (let num of nums) {
        if (num === 0) {
            positive = 0;
            negative = 0;
        } else if (num > 0) {
            positive++;
            negative = (negative === 0 ? 0 : negative + 1);
        } else {
            let temp = positive;
            positive = (negative === 0 ? 0 : negative + 1);
            negative = temp + 1;
        }
        maxLen = Math.max(maxLen, positive);
    }

    return maxLen;
}