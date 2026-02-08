var findMinimumOperations = function(s1, s2, s3) {
    let minLen = Math.min(s1.length, s2.length, s3.length);
    let common = 0;
    for (let i = 0; i < minLen; i++) {
        if (s1[i] === s2[i] && s2[i] === s3[i]) {
            common++;
        } else {
            break;
        }
    }
    if (common === 0) return -1;
    return (s1.length + s2.length + s3.length) - 3 * common;
};