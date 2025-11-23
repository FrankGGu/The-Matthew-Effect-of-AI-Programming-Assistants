function longestRepeatingSubstring(s) {
    let left = 0, right = s.length - 1;
    let maxLen = 0;

    while (left <= right) {
        let i = left + 1;
        let j = left;
        let count = 1;

        while (i <= right && s[i] === s[j]) {
            count++;
            i++;
            j++;
        }

        maxLen = Math.max(maxLen, count);
        left++;
    }

    return maxLen;
}