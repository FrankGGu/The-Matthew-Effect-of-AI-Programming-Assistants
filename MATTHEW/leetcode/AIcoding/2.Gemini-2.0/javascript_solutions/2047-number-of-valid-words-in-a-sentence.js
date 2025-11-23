var countValidWords = function(sentence) {
    const words = sentence.split(" ");
    let count = 0;

    for (const word of words) {
        if (word === "") continue;

        let isValid = true;
        let hyphenCount = 0;

        for (let i = 0; i < word.length; i++) {
            const char = word[i];

            if (/[0-9]/.test(char)) {
                isValid = false;
                break;
            }

            if (char === '-') {
                hyphenCount++;
                if (hyphenCount > 1) {
                    isValid = false;
                    break;
                }
                if (i === 0 || i === word.length - 1) {
                    isValid = false;
                    break;
                }
                if (!/[a-z]/.test(word[i - 1]) || !/[a-z]/.test(word[i + 1])) {
                    isValid = false;
                    break;
                }
            }

            if (/[!.,]/.test(char)) {
                if (i !== word.length - 1) {
                    isValid = false;
                    break;
                }
            }
        }

        if (isValid) {
            count++;
        }
    }

    return count;
};