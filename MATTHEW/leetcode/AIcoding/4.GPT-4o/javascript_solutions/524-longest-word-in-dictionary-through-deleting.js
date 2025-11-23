var findLongestWord = function(s, dictionary) {
    dictionary.sort((a, b) => a.length === b.length ? a.localeCompare(b) : b.length - a.length);
    for (let word of dictionary) {
        let i = 0, j = 0;
        while (i < s.length && j < word.length) {
            if (s[i] === word[j]) j++;
            i++;
        }
        if (j === word.length) return word;
    }
    return "";
};