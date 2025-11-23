var longestSemiRepetitiveSubstring = function(s) {
    let maxLen = 1;
    let left = 0;
    let count = 0;

    for (let right = 1; right < s.length; right++) {
        if (s[right] === s[right - 1]) {
            count++;
        }
        while (count > 1) {
            if (s[left] === s[left + 1]) {
                count--;
            }
            left++;
        }
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};