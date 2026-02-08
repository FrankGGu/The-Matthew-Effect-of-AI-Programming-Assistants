function findTheLongestSubstring(s) {
    const map = new Map();
    map.set(0, -1);
    let maxLength = 0;
    let state = 0;

    for (let i = 0; i < s.length; i++) {
        if ('aeiou'.includes(s[i])) {
            state ^= 1 << 'aeiou'.indexOf(s[i]);
        }

        if (map.has(state)) {
            maxLength = Math.max(maxLength, i - map.get(state));
        } else {
            map.set(state, i);
        }
    }

    return maxLength;
}