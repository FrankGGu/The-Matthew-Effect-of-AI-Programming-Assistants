var ladderLength = function(beginWord, endWord, wordList) {
    if (!wordList.includes(endWord)) return 0;

    const wordSet = new Set(wordList);
    const queue = [[beginWord, 1]];
    const visited = new Set();
    visited.add(beginWord);

    while (queue.length > 0) {
        const [currentWord, level] = queue.shift();

        if (currentWord === endWord) {
            return level;
        }

        for (let i = 0; i < currentWord.length; i++) {
            for (let j = 0; j < 26; j++) {
                const char = String.fromCharCode(97 + j);
                if (char !== currentWord[i]) {
                    const newWord = currentWord.slice(0, i) + char + currentWord.slice(i + 1);
                    if (wordSet.has(newWord) && !visited.has(newWord)) {
                        queue.push([newWord, level + 1]);
                        visited.add(newWord);
                    }
                }
            }
        }
    }

    return 0;
};