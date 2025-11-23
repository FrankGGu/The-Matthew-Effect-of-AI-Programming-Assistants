var longestSemiRepetitiveSubstring = function(s) {
    let n = s.length;
    let maxLength = 0;
    let count = 0;
    let left = 0;

    for (let right = 0; right < n; right++) {
        if (right > 0 && s[right] === s[right - 1]) {
            count++;
        }

        while (count > 1) {
            if (s[left] === s[left + 1]) {
                count--;
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};