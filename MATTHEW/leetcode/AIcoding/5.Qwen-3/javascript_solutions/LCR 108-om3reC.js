function ladderLength(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) return 0;

    const queue = [beginWord];
    let length = 1;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            if (current === endWord) return length;

            for (let j = 0; j < current.length; j++) {
                for (let c = 97; c <= 122; c++) {
                    const nextWord = current.slice(0, j) + String.fromCharCode(c) + current.slice(j + 1);
                    if (wordSet.has(nextWord)) {
                        queue.push(nextWord);
                        wordSet.delete(nextWord);
                    }
                }
            }
        }
        length++;
    }

    return 0;
}