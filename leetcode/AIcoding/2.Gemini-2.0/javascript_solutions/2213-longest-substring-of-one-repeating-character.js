var characterReplacement = function(s, k) {
    let left = 0;
    let right = 0;
    let maxLength = 0;
    let maxCharCount = 0;
    let charCounts = {};

    while (right < s.length) {
        const char = s[right];
        charCounts[char] = (charCounts[char] || 0) + 1;
        maxCharCount = Math.max(maxCharCount, charCounts[char]);

        while (right - left + 1 - maxCharCount > k) {
            charCounts[s[left]]--;
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};