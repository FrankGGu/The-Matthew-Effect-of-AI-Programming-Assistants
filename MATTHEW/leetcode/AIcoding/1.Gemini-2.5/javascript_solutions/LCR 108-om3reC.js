var ladderLength = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);

    if (!wordSet.has(endWord)) {
        return 0;
    }

    const queue = [[beginWord, 1]];
    const visited = new Set([beginWord]);

    while (queue.length > 0) {
        const [currentWord, level] = queue.shift();

        if (currentWord === endWord) {
            return level;
        }

        for (let i = 0; i < currentWord.length; i++) {
            const originalChar = currentWord[i];
            for (let charCode = 97; charCode <= 122; charCode++) {
                const char = String.fromCharCode(charCode);
                if (originalChar === char) continue;

                const nextWord = currentWord.substring(0, i) + char + currentWord.substring(i + 1);

                if (wordSet.has(nextWord) && !visited.has(nextWord)) {
                    visited.add(nextWord);
                    queue.push([nextWord, level + 1]);
                }
            }
        }
    }

    return 0;
};