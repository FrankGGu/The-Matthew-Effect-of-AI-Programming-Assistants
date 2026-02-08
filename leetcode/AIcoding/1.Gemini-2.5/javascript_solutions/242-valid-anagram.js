var isAnagram = function(s, t) {
    if (s.length !== t.length) {
        return false;
    }

    const charCounts = new Array(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        charCounts[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < t.length; i++) {
        const charIndex = t.charCodeAt(i) - 'a'.charCodeAt(0);
        charCounts[charIndex]--;
        if (charCounts[charIndex] < 0) {
            return false;
        }
    }

    return true;
};