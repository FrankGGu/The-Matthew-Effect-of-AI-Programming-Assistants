function findLadders(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) return [];
    const result = [];
    const level = {};
    level[beginWord] = [beginWord];
    const nextLevel = {};
    let found = false;
    while (Object.keys(level).length > 0 && !found) {
        for (const word in level) {
            const currList = level[word];
            for (let i = 0; i < word.length; i++) {
                const prefix = word.substring(0, i);
                const suffix = word.substring(i + 1);
                for (let c = 0; c < 26; c++) {
                    const nextWord = prefix + String.fromCharCode(97 + c) + suffix;
                    if (wordSet.has(nextWord)) {
                        if (!nextLevel[nextWord]) nextLevel[nextWord] = [];
                        nextLevel[nextWord].push(...currList, nextWord);
                        if (nextWord === endWord) found = true;
                    }
                }
            }
        }
        for (const word in nextLevel) {
            if (level[word]) {
                nextLevel[word] = nextLevel[word].filter(w => w !== word);
            }
        }
        level.clear();
        Object.assign(level, nextLevel);
        nextLevel.clear();
    }
    return result;
}