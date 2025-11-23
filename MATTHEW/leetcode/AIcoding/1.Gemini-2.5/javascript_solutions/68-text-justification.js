var fullJustify = function(words, maxWidth) {
    const result = [];
    let i = 0; // current word index in words array

    while (i < words.length) {
        let currentLineWords = [];
        let currentLineWordsLength = 0; // sum of lengths of words in currentLineWords
        let j = i; // pointer for words to consider for the current line

        // Greedily pack words into the current line
        while (j < words.length) {
            const word = words[j];
            // Calculate the length if 'word' is added to the current line.
            // This includes sum of word lengths and minimum 1 space for each gap.
            // If currentLineWords is empty, no gaps yet, so `currentLineWords.length` is 0.
            // If currentLineWords has k words, adding a new word creates k gaps.
            const potentialLengthWithSpaces = currentLineWordsLength + word.length + currentLineWords.length;

            if (potentialLengthWithSpaces <= maxWidth) {
                currentLineWords.push(word);
                currentLineWordsLength += word.length;
                j++;
            } else {
                break;
            }
        }

        const numGaps = currentLineWords.length - 1;
        let line = "";

        // Case 1: Last line or a line with a single word
        if (j === words.length || numGaps === 0) {
            line = currentLineWords.join(" ");
            line += " ".repeat(maxWidth - line.length);
        } else { // Case 2: Regular line with multiple words
            const totalSpacesNeeded = maxWidth - currentLineWordsLength; // Total spaces to distribute
            const baseSpacesPerGap = Math.floor(totalSpacesNeeded / numGaps);
            let extraSpacesToDistribute = totalSpacesNeeded % numGaps;

            for (let k = 0; k < currentLineWords.length; k++) {
                line += currentLineWords[k];
                if (k < numGaps) { // Not the last word in the line
                    line += " ".repeat(baseSpacesPerGap);
                    if (extraSpacesToDistribute > 0) {
                        line += " ";
                        extraSpacesToDistribute--;
                    }
                }
            }
        }
        result.push(line);
        i = j; // Move to the next set of words
    }

    return result;
};