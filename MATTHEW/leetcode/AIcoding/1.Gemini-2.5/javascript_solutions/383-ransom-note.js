var canConstruct = function(ransomNote, magazine) {
    const charCounts = new Map();

    for (const char of magazine) {
        charCounts.set(char, (charCounts.get(char) || 0) + 1);
    }

    for (const char of ransomNote) {
        if (!charCounts.has(char) || charCounts.get(char) === 0) {
            return false;
        }
        charCounts.set(char, charCounts.get(char) - 1);
    }

    return true;
};