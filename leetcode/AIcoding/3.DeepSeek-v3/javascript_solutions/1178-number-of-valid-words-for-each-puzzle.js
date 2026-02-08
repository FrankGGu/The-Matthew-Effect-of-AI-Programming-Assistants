var findNumOfValidWords = function(words, puzzles) {
    const wordCount = {};
    for (const word of words) {
        let mask = 0;
        for (const c of word) {
            mask |= 1 << (c.charCodeAt(0) - 'a'.charCodeAt(0);
        }
        if (wordCount[mask] === undefined) {
            wordCount[mask] = 0;
        }
        wordCount[mask]++;
    }

    const result = [];
    for (const puzzle of puzzles) {
        const firstCharMask = 1 << (puzzle.charCodeAt(0) - 'a'.charCodeAt(0));
        let count = 0;
        let mask = 0;
        for (let i = 1; i < puzzle.length; i++) {
            mask |= 1 << (puzzle.charCodeAt(i) - 'a'.charCodeAt(0));
        }
        let subset = mask;
        while (true) {
            const currentMask = subset | firstCharMask;
            if (wordCount[currentMask] !== undefined) {
                count += wordCount[currentMask];
            }
            if (subset === 0) break;
            subset = (subset - 1) & mask;
        }
        result.push(count);
    }
    return result;
};