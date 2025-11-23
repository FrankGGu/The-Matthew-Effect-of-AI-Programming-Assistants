function longestSemicolonSubarray(s) {
    let maxLen = 0;
    let count = 0;
    let firstIndex = -1;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === ';') {
            count++;
            if (count === 1) {
                firstIndex = i;
            } else if (count === 2) {
                maxLen = Math.max(maxLen, i - firstIndex + 1);
                count = 1;
                firstIndex = i;
            }
        }
    }

    return maxLen;
}