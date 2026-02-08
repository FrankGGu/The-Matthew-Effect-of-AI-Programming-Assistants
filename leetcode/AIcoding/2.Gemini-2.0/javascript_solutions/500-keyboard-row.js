var findWords = function(words) {
    const rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];
    const result = [];

    for (const word of words) {
        const lowerWord = word.toLowerCase();
        let row = -1;

        for (let i = 0; i < rows.length; i++) {
            if (rows[i].includes(lowerWord[0])) {
                row = i;
                break;
            }
        }

        let valid = true;
        for (let i = 1; i < lowerWord.length; i++) {
            if (!rows[row].includes(lowerWord[i])) {
                valid = false;
                break;
            }
        }

        if (valid) {
            result.push(word);
        }
    }

    return result;
};