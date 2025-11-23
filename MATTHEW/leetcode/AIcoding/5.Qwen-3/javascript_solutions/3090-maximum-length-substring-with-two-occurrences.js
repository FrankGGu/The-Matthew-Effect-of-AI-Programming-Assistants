function maximumLengthSubstring(s) {
    let left = 0;
    let maxLen = 0;
    const count = {};

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        count[char] = (count[char] || 0) + 1;

        while (count[char] > 2) {
            const leftChar = s[left];
            count[leftChar]--;
            if (count[leftChar] === 0) {
                delete count[leftChar];
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}