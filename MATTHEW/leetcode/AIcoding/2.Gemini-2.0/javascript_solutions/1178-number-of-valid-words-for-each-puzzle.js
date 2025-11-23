var findNumOfValidWords = function(words, puzzles) {
    const wordMasks = words.map(word => {
        let mask = 0;
        for (const char of word) {
            mask |= (1 << (char.charCodeAt(0) - 'a'.charCodeAt(0)));
        }
        return mask;
    });

    const result = [];
    for (const puzzle of puzzles) {
        let count = 0;
        const firstCharMask = 1 << (puzzle.charCodeAt(0) - 'a'.charCodeAt(0));
        for (const wordMask of wordMasks) {
            if ((wordMask & firstCharMask) !== 0) {
                let puzzleMask = 0;
                for (const char of puzzle) {
                    puzzleMask |= (1 << (char.charCodeAt(0) - 'a'.charCodeAt(0)));
                }
                if ((wordMask & puzzleMask) === wordMask) {
                    count++;
                }
            }
        }
        result.push(count);
    }
    return result;
};