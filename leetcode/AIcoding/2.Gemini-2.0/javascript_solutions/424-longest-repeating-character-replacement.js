var characterReplacement = function(s, k) {
    let left = 0;
    let right = 0;
    let maxLength = 0;
    let maxCount = 0;
    const charCounts = {};

    while (right < s.length) {
        const char = s[right];
        charCounts[char] = (charCounts[char] || 0) + 1;
        maxCount = Math.max(maxCount, charCounts[char]);

        while (right - left + 1 - maxCount > k) {
            charCounts[s[left]]--;
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};