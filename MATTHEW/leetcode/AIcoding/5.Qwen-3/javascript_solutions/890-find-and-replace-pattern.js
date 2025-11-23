function findAndReplacePattern(words, pattern) {
    function getPattern(word) {
        const map = {};
        let result = '';
        for (let i = 0; i < word.length; i++) {
            if (!(word[i] in map)) {
                map[word[i]] = Object.keys(map).length;
            }
            result += map[word[i]] + '.';
        }
        return result;
    }

    const patternStr = getPattern(pattern);
    const result = [];

    for (const word of words) {
        if (getPattern(word) === patternStr) {
            result.push(word);
        }
    }

    return result;
}