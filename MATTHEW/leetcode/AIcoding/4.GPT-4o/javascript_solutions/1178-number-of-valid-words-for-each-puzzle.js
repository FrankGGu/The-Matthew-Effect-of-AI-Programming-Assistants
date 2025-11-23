var findNumOfValidWords = function(words, puzzles) {
    const wordCount = new Map();

    for (const word of words) {
        let mask = 0;
        for (const char of new Set(word)) {
            mask |= 1 << (char.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        wordCount.set(mask, (wordCount.get(mask) || 0) + 1);
    }

    const result = [];

    for (const puzzle of puzzles) {
        const firstCharMask = 1 << (puzzle[0].charCodeAt(0) - 'a'.charCodeAt(0));
        let count = 0;

        for (const [mask, cnt] of wordCount) {
            if ((mask & firstCharMask) === 0) continue;
            let valid = true;
            for (let i = 1; i < puzzle.length; i++) {
                if ((mask & (1 << (puzzle[i].charCodeAt(0) - 'a'.charCodeAt(0)))) === 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) count += cnt;
        }

        result.push(count);
    }

    return result;
};