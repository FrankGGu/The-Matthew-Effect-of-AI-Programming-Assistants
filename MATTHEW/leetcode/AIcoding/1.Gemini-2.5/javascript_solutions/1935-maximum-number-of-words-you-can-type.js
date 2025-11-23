var canBeTypedWords = function(text, brokenLetters) {
    const brokenSet = new Set();
    for (const char of brokenLetters) {
        brokenSet.add(char);
    }

    const words = text.split(' ');
    let typableWordsCount = 0;

    for (const word of words) {
        let canType = true;
        for (const char of word) {
            if (brokenSet.has(char)) {
                canType = false;
                break;
            }
        }
        if (canType) {
            typableWordsCount++;
        }
    }

    return typableWordsCount;
};