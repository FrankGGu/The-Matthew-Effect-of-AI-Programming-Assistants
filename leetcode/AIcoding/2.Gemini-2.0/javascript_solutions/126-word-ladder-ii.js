var findLadders = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) return [];

    let queue = [[beginWord, [beginWord]]];
    const visited = new Set([beginWord]);
    const result = [];
    let found = false;
    let minLength = Infinity;

    while (queue.length > 0) {
        const [word, path] = queue.shift();

        if (path.length > minLength) continue;

        if (word === endWord) {
            found = true;
            minLength = path.length;
            result.push(path);
            continue;
        }

        if (found && path.length > minLength) continue;

        for (let i = 0; i < word.length; i++) {
            for (let j = 0; j < 26; j++) {
                const charCode = 'a'.charCodeAt(0) + j;
                const newChar = String.fromCharCode(charCode);
                const newWord = word.substring(0, i) + newChar + word.substring(i + 1);

                if (wordSet.has(newWord) && !visited.has(newWord)) {
                    queue.push([newWord, [...path, newWord]]);
                }
            }
        }

        visited.add(word);
    }

    return result.filter(path => path.length === minLength);
};