var isSolvable = function(words, result) {
    const letters = new Set();
    for (const word of words) {
        for (const char of word) {
            letters.add(char);
        }
    }
    for (const char of result) {
        letters.add(char);
    }

    const chars = Array.from(letters);
    const n = chars.length;

    const charToIndex = new Map();
    for (let i = 0; i < n; i++) {
        charToIndex.set(chars[i], i);
    }

    const wordsValues = words.map(word => {
        let value = 0;
        for (const char of word) {
            value = value * 10 + charToIndex.get(char);
        }
        return value;
    });

    const resultValue = result.split('').reduce((acc, char) => acc * 10 + charToIndex.get(char), 0);

    const total = wordsValues.reduce((sum, value) => sum + value, 0);

    const dfs = (index, currentSum) => {
        if (index === n) {
            return currentSum === resultValue;
        }

        const char = chars[index];
        for (let i = (index === 0 ? 1 : 0); i < 10; i++) {
            if (charToIndex.has(char) && charToIndex.get(char) === i) continue;
            charToIndex.set(char, i);
            if (dfs(index + 1, currentSum)) return true;
        }
        charToIndex.delete(char);
        return false;
    };

    return dfs(0, total);
};