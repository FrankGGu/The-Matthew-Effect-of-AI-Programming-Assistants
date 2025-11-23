var findTheLongestSubstring = function(s) {
    const vowels = { 'a': 1, 'e': 2, 'i': 4, 'o': 8, 'u': 16 };
    let state = 0;
    const firstSeen = new Map();
    firstSeen.set(0, -1);
    let maxLen = 0;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (vowels[char] !== undefined) {
            state ^= vowels[char];
        }
        if (!firstSeen.has(state)) {
            firstSeen.set(state, i);
        } else {
            maxLen = Math.max(maxLen, i - firstSeen.get(state));
        }
    }

    return maxLen;
};