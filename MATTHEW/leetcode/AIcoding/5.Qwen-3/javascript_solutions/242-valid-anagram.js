function isAnagram(s, t) {
    if (s.length !== t.length) {
        return false;
    }
    const count = {};
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        count[char] = (count[char] || 0) + 1;
    }
    for (let i = 0; i < t.length; i++) {
        const char = t[i];
        if (!count[char]) {
            return false;
        }
        count[char]--;
    }
    return true;
}