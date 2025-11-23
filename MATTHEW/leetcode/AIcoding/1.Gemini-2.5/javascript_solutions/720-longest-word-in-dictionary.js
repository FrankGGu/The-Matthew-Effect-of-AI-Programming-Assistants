var longestWord = function(words) {
    words.sort();

    let validWords = new Set();
    let longestWord = "";

    for (let word of words) {
        if (word.length === 1 || validWords.has(word.slice(0, word.length - 1))) {
            validWords.add(word);

            if (word.length > longestWord.length) {
                longestWord = word;
            }
        }
    }

    return longestWord;
};