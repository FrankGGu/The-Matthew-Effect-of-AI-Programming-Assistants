function findNumOfValidWords(contacts, puzzles) {
    const wordMap = new Map();

    for (const word of contacts) {
        let mask = 0;
        for (const c of word) {
            mask |= 1 << (c.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        wordMap.set(mask, (wordMap.get(mask) || 0) + 1);
    }

    const result = [];

    for (const puzzle of puzzles) {
        let count = 0;
        const pMask = puzzle.split('').reduce((acc, c) => acc | (1 << (c.charCodeAt(0) - 'a'.charCodeAt(0))), 0);
        const firstChar = 1 << (puzzle[0].charCodeAt(0) - 'a'.charCodeAt(0));

        let submask = pMask;
        while (submask) {
            if ((submask & firstChar) !== 0) {
                count += wordMap.get(submask) || 0;
            }
            submask = (submask - 1) & pMask;
        }

        result.push(count);
    }

    return result;
}