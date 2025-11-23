var findWords = function(words) {
    const row1 = new Set('qwertyuiop');
    const row2 = new Set('asdfghjkl');
    const row3 = new Set('zxcvbnm');

    const checkWord = (word) => {
        if (word.length === 0) {
            return true;
        }
        const lowerCaseWord = word.toLowerCase();
        let currentRow = null;

        if (row1.has(lowerCaseWord[0])) {
            currentRow = row1;
        } else if (row2.has(lowerCaseWord[0])) {
            currentRow = row2;
        } else if (row3.has(lowerCaseWord[0])) {
            currentRow = row3;
        } else {
            return false;
        }

        for (let i = 1; i < lowerCaseWord.length; i++) {
            if (!currentRow.has(lowerCaseWord[i])) {
                return false;
            }
        }
        return true;
    };

    const result = [];
    for (const word of words) {
        if (checkWord(word)) {
            result.push(word);
        }
    }
    return result;
};