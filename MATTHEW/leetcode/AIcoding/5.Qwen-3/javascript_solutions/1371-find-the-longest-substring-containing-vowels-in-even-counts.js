var findTheLongestSubstring = function(s) {
    const map = new Map();
    map.set(0, -1);
    let state = 0;
    let maxLen = 0;
    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (c === 'a') state ^= 1 << 0;
        else if (c === 'e') state ^= 1 << 1;
        else if (c === 'i') state ^= 1 << 2;
        else if (c === 'o') state ^= 1 << 3;
        else if (c === 'u') state ^= 1 << 4;
        if (map.has(state)) {
            maxLen = Math.max(maxLen, i - map.get(state));
        } else {
            map.set(state, i);
        }
    }
    return maxLen;
};