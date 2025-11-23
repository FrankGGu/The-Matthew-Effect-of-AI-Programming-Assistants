var isAnagram = function(s, t) {
    if (s.length !== t.length) {
        return false;
    }

    const sCharCounts = {};
    const tCharCounts = {};

    for (let i = 0; i < s.length; i++) {
        sCharCounts[s[i]] = (sCharCounts[s[i]] || 0) + 1;
        tCharCounts[t[i]] = (tCharCounts[t[i]] || 0) + 1;
    }

    for (const char in sCharCounts) {
        if (sCharCounts[char] !== tCharCounts[char]) {
            return false;
        }
    }

    return true;
};