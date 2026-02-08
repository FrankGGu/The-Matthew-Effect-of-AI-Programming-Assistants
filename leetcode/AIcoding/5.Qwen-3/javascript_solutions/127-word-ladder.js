function ladderLength(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) return 0;

    const queue = [beginWord];
    let level = 1;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const currentWord = queue.shift();
            if (currentWord === endWord) return level;

            for (let j = 0; j < currentWord.length; j++) {
                for (let c = 97; c <= 122; c++) {
                    const nextWord = currentWord.slice(0, j) + String.fromCharCode(c) + currentWord.slice(j + 1);
                    if (wordSet.has(nextWord)) {
                        queue.push(nextWord);
                        wordSet.delete(nextWord);
                    }
                }
            }
        }
        level++;
    }

    return 0;
}