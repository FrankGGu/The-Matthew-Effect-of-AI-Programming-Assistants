var canConstruct = function(ransomNote, magazine) {
    const magazineCount = {};
    for (const char of magazine) {
        magazineCount[char] = (magazineCount[char] || 0) + 1;
    }
    for (const char of ransomNote) {
        if (!magazineCount[char]) return false;
        magazineCount[char]--;
    }
    return true;
};