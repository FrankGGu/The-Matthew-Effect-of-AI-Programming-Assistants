var maximumLengthSubstring = function(s) {
    let maxLen = 0;
    let left = 0;
    const freq = {};

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        freq[char] = (freq[char] || 0) + 1;

        while (freq[char] > 2) {
            const leftChar = s[left];
            freq[leftChar]--;
            if (freq[leftChar] === 0) {
                delete freq[leftChar];
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};