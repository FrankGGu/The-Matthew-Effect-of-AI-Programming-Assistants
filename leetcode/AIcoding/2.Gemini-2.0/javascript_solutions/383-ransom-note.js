var canConstruct = function(ransomNote, magazine) {
    const magazineChars = {};
    for (let char of magazine) {
        magazineChars[char] = (magazineChars[char] || 0) + 1;
    }

    for (let char of ransomNote) {
        if (!magazineChars[char]) {
            return false;
        }
        magazineChars[char]--;
    }

    return true;
};