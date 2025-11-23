var countSubstrings = function(s, k) {
    let count = 0;
    let left = 0;
    const charMap = new Map();

    for (let right = 0; right < s.length; right++) {
        const charR = s[right];
        charMap.set(charR, (charMap.get(charR) || 0) + 1);

        while (charMap.size > k) {
            const charL = s[left];
            charMap.set(charL, charMap.get(charL) - 1);
            if (charMap.get(charL) === 0) {
                charMap.delete(charL);
            }
            left++;
        }

        count += (right - left + 1);
    }

    return count;
};