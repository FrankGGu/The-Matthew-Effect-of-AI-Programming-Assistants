var canConstruct = function(ransomNote, magazine) {
    const map = {};
    for (const char of magazine) {
        map[char] = (map[char] || 0) + 1;
    }
    for (const char of ransomNote) {
        if (!map[char]) {
            return false;
        }
        map[char]--;
    }
    return true;
};