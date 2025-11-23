function maxConfusion(s, c) {
    let left = 0;
    let maxLen = 0;
    let count = 0;

    for (let right = 0; right < s.length; right++) {
        if (s[right] !== c) {
            count++;
        }

        while (count > 1) {
            if (s[left] !== c) {
                count--;
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}