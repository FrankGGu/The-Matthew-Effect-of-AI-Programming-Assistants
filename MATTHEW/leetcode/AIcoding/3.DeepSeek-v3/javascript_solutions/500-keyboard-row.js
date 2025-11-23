var findWords = function(words) {
    const row1 = new Set("qwertyuiop");
    const row2 = new Set("asdfghjkl");
    const row3 = new Set("zxcvbnm");

    const result = [];

    for (const word of words) {
        const lowerWord = word.toLowerCase();
        let inRow1 = true, inRow2 = true, inRow3 = true;

        for (const char of lowerWord) {
            if (!row1.has(char)) inRow1 = false;
            if (!row2.has(char)) inRow2 = false;
            if (!row3.has(char)) inRow3 = false;
        }

        if (inRow1 || inRow2 || inRow3) {
            result.push(word);
        }
    }

    return result;
};