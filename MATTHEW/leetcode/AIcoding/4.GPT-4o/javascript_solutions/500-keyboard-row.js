var findWords = function(words) {
    const rows = [
        new Set('qwertyuiop'),
        new Set('asdfghjkl'),
        new Set('zxcvbnm')
    ];

    return words.filter(word => {
        const lowerWord = word.toLowerCase();
        for (const row of rows) {
            if (lowerWord.split('').every(char => row.has(char))) {
                return true;
            }
        }
        return false;
    });
};