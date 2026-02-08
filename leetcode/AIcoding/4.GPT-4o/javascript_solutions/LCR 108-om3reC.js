var ladderLength = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) return 0;

    let queue = [[beginWord, 1]];
    while (queue.length > 0) {
        const [word, length] = queue.shift();
        if (word === endWord) return length;

        for (let i = 0; i < word.length; i++) {
            for (let char = 'a'.charCodeAt(0); char <= 'z'.charCodeAt(0); char++) {
                const newChar = String.fromCharCode(char);
                const newWord = word.slice(0, i) + newChar + word.slice(i + 1);
                if (wordSet.has(newWord)) {
                    queue.push([newWord, length + 1]);
                    wordSet.delete(newWord);
                }
            }
        }
    }
    return 0;
};