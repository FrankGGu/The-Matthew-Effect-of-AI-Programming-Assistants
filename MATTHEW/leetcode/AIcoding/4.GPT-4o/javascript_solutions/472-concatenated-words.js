var findAllConcatenatedWordsInADict = function(words) {
    const wordSet = new Set(words);
    const result = [];

    const canForm = (word) => {
        if (wordSet.has(word)) return true;
        for (let i = 1; i < word.length; i++) {
            const prefix = word.slice(0, i);
            const suffix = word.slice(i);
            if (wordSet.has(prefix) && canForm(suffix)) {
                return true;
            }
        }
        return false;
    };

    for (const word of words) {
        wordSet.delete(word);
        if (canForm(word)) {
            result.push(word);
        }
        wordSet.add(word);
    }

    return result;
};