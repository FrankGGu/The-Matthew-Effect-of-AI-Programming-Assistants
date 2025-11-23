var countValidWords = function(sentence) {
    const tokens = sentence.split(/\s+/).filter(token => token.length > 0);
    let count = 0;

    for (const token of tokens) {
        let isValid = true;
        let hyphenCount = 0;

        for (let i = 0; i < token.length; i++) {
            const c = token[i];

            if (c >= '0' && c <= '9') {
                isValid = false;
                break;
            }

            if (c === '-') {
                hyphenCount++;
                if (hyphenCount > 1 || 
                    i === 0 || 
                    i === token.length - 1 || 
                    !isLetter(token[i - 1]) || 
                    !isLetter(token[i + 1])) {
                    isValid = false;
                    break;
                }
            }

            if ((c === '!' || c === '.' || c === ',') && i !== token.length - 1) {
                isValid = false;
                break;
            }
        }

        if (isValid) {
            count++;
        }
    }

    return count;
};

function isLetter(c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}