var longestWord = function(words) {
    words.sort((a, b) => {
        if (a.length !== b.length) {
            return b.length - a.length;
        } else {
            return a.localeCompare(b);
        }
    });

    const wordSet = new Set();
    wordSet.add("");

    let result = "";
    for (const word of words) {
        if (wordSet.has(word.slice(0, word.length - 1))) {
            wordSet.add(word);
            result = word;
            break;
        }
    }

    return result;
};