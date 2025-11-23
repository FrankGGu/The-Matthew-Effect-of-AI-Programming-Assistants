var findMaximumLength = function(s1, s2, s3) {
    let minLen = Math.min(s1.length, s2.length, s3.length);
    let commonPrefixLength = 0;

    for (let i = 0; i < minLen; i++) {
        if (s1[i] === s2[i] && s2[i] === s3[i]) {
            commonPrefixLength++;
        } else {
            break;
        }
    }

    return commonPrefixLength;
};