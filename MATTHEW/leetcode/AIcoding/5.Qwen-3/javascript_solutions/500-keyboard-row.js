function findWords(words) {
    const row1 = new Set("qwertyuiop");
    const row2 = new Set("asdfghjkl");
    const row3 = new Set("zxcvbnm");

    return words.filter(word => {
        const lowerWord = word.toLowerCase();
        const firstChar = lowerWord[0];
        if (row1.has(firstChar)) {
            return [...lowerWord].every(c => row1.has(c));
        } else if (row2.has(firstChar)) {
            return [...lowerWord].every(c => row2.has(c));
        } else {
            return [...lowerWord].every(c => row3.has(c));
        }
    });
}