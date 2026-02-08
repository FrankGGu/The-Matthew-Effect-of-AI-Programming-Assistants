var countCharacters = function(words, chars) {
    const countChars = (str) => {
        const count = {};
        for (const char of str) {
            count[char] = (count[char] || 0) + 1;
        }
        return count;
    };

    const charsCount = countChars(chars);
    let total = 0;

    for (const word of words) {
        const wordCount = countChars(word);
        let canForm = true;
        for (const char in wordCount) {
            if (!charsCount[char] || wordCount[char] > charsCount[char]) {
                canForm = false;
                break;
            }
        }
        if (canForm) {
            total += word.length;
        }
    }

    return total;
};