var isAnagram = function(s, t) {
    if (s.length !== t.length) {
        return false;
    }

    const sCharCounts = {};
    for (let char of s) {
        sCharCounts[char] = (sCharCounts[char] || 0) + 1;
    }

    for (let char of t) {
        if (!sCharCounts[char]) {
            return false;
        }
        sCharCounts[char]--;
    }

    return true;
};