var countVowelSubstrings = function(word) {
    let count = 0;
    for (let i = 0; i < word.length; i++) {
        for (let j = i; j < word.length; j++) {
            const sub = word.substring(i, j + 1);
            if (isVowelSubstring(sub)) {
                count++;
            }
        }
    }
    return count;

    function isVowelSubstring(s) {
        const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
        for (let char of s) {
            if (!vowels.has(char)) {
                return false;
            }
        }
        const vowelSet = new Set(s.split(''));
        return vowelSet.size === 5;
    }
};