var findNumOfValidWords = function(words, puzzles) {
    const wordMaskCounts = new Map();

    // Preprocess words: create a bitmask for each word and count occurrences of each unique mask.
    // A bitmask represents the set of unique characters in a word.
    // For example, 'a' corresponds to the 0th bit, 'b' to the 1st bit, and so on.
    for (const word of words) {
        let mask = 0;
        for (let i = 0; i < word.length; i++) {
            mask |= (1 << (word.charCodeAt(i) - 'a'.charCodeAt(0)));
        }
        wordMaskCounts.set(mask, (wordMaskCounts.get(mask) || 0) + 1);
    }

    const result = [];

    // Process each puzzle
    for (const puzzle of puzzles) {
        let puzzleMask = 0;
        // The first letter of the puzzle must be present in a valid word.
        // Store its bitmask for quick checking.
        const firstLetterMask = (1 << (puzzle.charCodeAt(0) - 'a'.charCodeAt(0)));

        // Create a bitmask for the current puzzle.
        for (let i = 0; i < puzzle.length; i++) {
            puzzleMask |= (1 << (puzzle.charCodeAt(i) - 'a'.charCodeAt(0)));
        }

        let currentPuzzleCount = 0;

        // Iterate through all possible submasks of the puzzleMask.
        // A submask represents a potential set of characters that could form a valid word.
        // The loop `submask = (submask - 1) & puzzleMask` efficiently generates all submasks.
        let submask = puzzleMask;
        while (true) {
            // Condition 1: The word must contain the first letter of the puzzle.
            // This is checked by verifying if the 'firstLetterMask' bit is set in the 'submask'.
            if ((submask & firstLetterMask) !== 0) {
                // Condition 2: Every letter in the word must be in the puzzle.
                // This is inherently satisfied because 'submask' is a subset of 'puzzleMask'.
                // If a word's mask matches 'submask', it means all its characters are in the puzzle.
                if (wordMaskCounts.has(submask)) {
                    currentPuzzleCount += wordMaskCounts.get(submask);
                }
            }

            // If submask becomes 0, all non-zero submasks have been processed.
            if (submask === 0) {
                break;
            }
            // Move to the next submask.
            submask = (submask - 1) & puzzleMask;
        }
        result.push(currentPuzzleCount);
    }

    return result;
};