var findTheLongestSubstring = function(s) {
    let maxLength = 0;
    let mask = 0;
    let firstOccurrence = new Array(32).fill(-2);
    firstOccurrence[0] = -1;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === 'a') {
            mask ^= (1 << 0);
        } else if (char === 'e') {
            mask ^= (1 << 1);
        } else if (char === 'i') {
            mask ^= (1 << 2);
        } else if (char === 'o') {
            mask ^= (1 << 3);
        } else if (char === 'u') {
            mask ^= (1 << 4);
        }

        if (firstOccurrence[mask] !== -2) {
            maxLength = Math.max(maxLength, i - firstOccurrence[mask]);
        } else {
            firstOccurrence[mask] = i;
        }
    }

    return maxLength;
};