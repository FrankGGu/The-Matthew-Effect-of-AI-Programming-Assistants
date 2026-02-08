var findAllConcatenatedWordsInADict = function(words) {
    const wordSet = new Set(words);
    const memo = new Map();

    const isConcatenated = (word) => {
        if (memo.has(word)) return memo.get(word);
        for (let i = 1; i < word.length; i++) {
            const prefix = word.substring(0, i);
            const suffix = word.substring(i);
            if (wordSet.has(prefix) && (wordSet.has(suffix) || isConcatenated(suffix))) {
                memo.set(word, true);
                return true;
            }
        }
        memo.set(word, false);
        return false;
    };

    const result = [];
    for (const word of words) {
        wordSet.delete(word);
        if (isConcatenated(word)) {
            result.push(word);
        }
        wordSet.add(word);
    }
    return result;
};