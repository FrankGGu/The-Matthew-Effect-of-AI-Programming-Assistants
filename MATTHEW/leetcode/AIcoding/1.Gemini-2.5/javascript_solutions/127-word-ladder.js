var ladderLength = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) {
        return 0;
    }

    const queue = [[beginWord, 1]];
    const visited = new Set();
    visited.add(beginWord);

    while (queue.length > 0) {
        const [currentWord, currentLength] = queue.shift();

        if (currentWord === endWord) {
            return currentLength;
        }

        for (let i = 0; i < currentWord.length; i++) {
            const charArray = currentWord.split('');
            for (let charCode = 97; charCode <= 122; charCode++) { // 'a' to 'z'
                const char = String.fromCharCode(charCode);
                if (charArray[i] === char) {
                    continue;
                }
                charArray[i] = char;
                const nextWord = charArray.join('');

                if (wordSet.has(nextWord) && !visited.has(nextWord)) {
                    visited.add(nextWord);
                    queue.push([nextWord, currentLength + 1]);
                }
            }
        }
    }

    return 0;
};