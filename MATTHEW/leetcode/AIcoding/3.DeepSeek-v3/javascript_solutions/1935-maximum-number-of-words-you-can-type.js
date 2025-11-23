var canBeTypedWords = function(text, brokenLetters) {
    const brokenSet = new Set(brokenLetters.split(''));
    const words = text.split(' ');
    let count = 0;

    for (const word of words) {
        let canType = true;
        for (const char of word) {
            if (brokenSet.has(char)) {
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