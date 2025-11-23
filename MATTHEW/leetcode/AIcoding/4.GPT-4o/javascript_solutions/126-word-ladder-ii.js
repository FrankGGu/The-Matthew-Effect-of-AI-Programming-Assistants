var findLadders = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    const result = [];
    const map = new Map();
    const queue = [beginWord];
    let found = false;

    if (!wordSet.has(endWord)) return result;

    while (queue.length > 0 && !found) {
        const visited = new Set();
        const nextQueue = [];

        for (const word of queue) {
            if (word === endWord) found = true;
            const neighbors = getNeighbors(word, wordSet);
            for (const neighbor of neighbors) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    if (!map.has(neighbor)) map.set(neighbor, []);
                    map.get(neighbor).push(word);
                    nextQueue.push(neighbor);
                }
            }
        }
        queue.length = 0;
        for (const word of nextQueue) {
            if (!visited.has(word)) queue.push(word);
        }
    }

    const buildPaths = (word, path) => {
        path.push(word);
        if (word === beginWord) {
            result.push(path.reverse());
        } else {
            const prevWords = map.get(word) || [];
            for (const prevWord of prevWords) {
                buildPaths(prevWord, path.slice());
            }
        }
    };

    buildPaths(endWord, []);
    return result;
};

const getNeighbors = (word, wordSet) => {
    const neighbors = [];
    const chars = 'abcdefghijklmnopqrstuvwxyz';
    for (let i = 0; i < word.length; i++) {
        for (const char of chars) {
            if (char !== word[i]) {
                const newWord = word.slice(0, i) + char + word.slice(i + 1);
                if (wordSet.has(newWord)) {
                    neighbors.push(newWord);
                }
            }
        }
    }
    return neighbors;
};