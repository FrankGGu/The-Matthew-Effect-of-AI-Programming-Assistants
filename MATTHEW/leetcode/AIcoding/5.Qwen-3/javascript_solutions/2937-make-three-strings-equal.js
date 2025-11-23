function equalizeStrings(s1, s2, s3) {
    const minLen = Math.min(s1.length, s2.length, s3.length);
    let common = 0;
    for (let i = 0; i < minLen; i++) {
        if (s1[i] === s2[i] && s2[i] === s3[i]) {
            common++;
        } else {
            break;
        }
    }
    return common;
}