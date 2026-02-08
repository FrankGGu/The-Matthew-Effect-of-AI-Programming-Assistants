var maximumLengthSubstring = function(s) {
    let maxLength = 0;
    let left = 0;
    const charCount = new Map();
    let badCharCount = 0; // Counts characters whose frequency is > 2

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        charCount.set(char, (charCount.get(char) || 0) + 1);

        if (charCount.get(char) === 3) {
            badCharCount++;
        }

        while (badCharCount > 0) {
            const leftChar = s[left];
            charCount.set(leftChar, charCount.get(leftChar) - 1);

            if (charCount.get(leftChar) === 2) {
                badCharCount--;
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};