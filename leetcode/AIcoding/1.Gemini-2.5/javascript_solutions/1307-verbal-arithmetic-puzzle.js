var isSolvable = function(words, result) {
    const charToDigit = new Map();
    const usedDigits = new Array(10).fill(false);
    const uniqueChars = [];
    const leadingChars = new Set();

    for (const word of words) {
        if (word.length > 1) {
            leadingChars.add(word[0]);
        }
        for (const char of word) {
            if (!charToDigit.has(char)) {
                charToDigit.set(char, -1);
                uniqueChars.push(char);
            }
        }
    }

    if (result.length > 1) {
        leadingChars.add(result[0]);
    }
    for (const char of result) {
        if (!charToDigit.has(char)) {
            charToDigit.set(char, -1);
            uniqueChars.push(char);
        }
    }

    if (uniqueChars.length > 10) {
        return false;
    }

    function backtrack(k) {
        if (k === uniqueChars.length) {
            let sum = 0;
            for (const word of words) {
                let wordValue = 0;
                for (const char of word) {
                    wordValue = wordValue * 10 + charToDigit.get(char);
                }
                sum += wordValue;
            }

            let resultValue = 0;
            for (const char of result) {
                resultValue = resultValue * 10 + charToDigit.get(char);
            }

            return sum === resultValue;
        }

        const char = uniqueChars[k];

        for (let digit = 0; digit <= 9; digit++) {
            if (usedDigits[digit]) {
                continue;
            }
            if (digit === 0 && leadingChars.has(char)) {
                continue;
            }

            charToDigit.set(char, digit);
            usedDigits[digit] = true;

            if (backtrack(k + 1)) {
                return true;
            }

            charToDigit.set(char, -1);
            usedDigits[digit] = false;
        }

        return false;
    }

    return backtrack(0);
};