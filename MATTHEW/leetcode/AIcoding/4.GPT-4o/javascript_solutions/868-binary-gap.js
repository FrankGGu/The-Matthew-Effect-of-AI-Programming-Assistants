var binaryGap = function(n) {
    let lastIndex = -1;
    let maxGap = 0;
    for (let i = 0; n > 0; i++) {
        if (n & 1) {
            if (lastIndex !== -1) {
                maxGap = Math.max(maxGap, i - lastIndex);
            }
            lastIndex = i;
        }
        n >>= 1;
    }
    return maxGap;
};