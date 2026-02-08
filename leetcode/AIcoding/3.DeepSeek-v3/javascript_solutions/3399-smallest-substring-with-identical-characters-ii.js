var smallestSubstring = function(s) {
    let minLen = Infinity;
    let left = 0;
    const charCount = {};
    let maxFreq = 0;

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        charCount[char] = (charCount[char] || 0) + 1;
        maxFreq = Math.max(maxFreq, charCount[char]);

        while (right - left + 1 - maxFreq > 1) {
            const leftChar = s[left];
            charCount[leftChar]--;
            left++;
        }

        if (right - left + 1 - maxFreq <= 1) {
            minLen = Math.min(minLen, right - left + 1);
        }
    }

    return minLen === Infinity ? 0 : minLen;
};