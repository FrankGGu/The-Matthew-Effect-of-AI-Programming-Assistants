var canBeTypedWords = function(text, brokenLetters) {
    let words = text.split(" ");
    let count = 0;
    for (let word of words) {
        let canType = true;
        for (let char of brokenLetters) {
            if (word.includes(char)) {
                canType = false;
                break;
            }
        }
        if (canType) {
            count++;
        }
    }
    return count;
};