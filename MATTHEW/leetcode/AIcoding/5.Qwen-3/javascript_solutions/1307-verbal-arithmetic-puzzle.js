function isSolvable(letters, mapping) {
    const letterToDigit = {};
    const usedDigits = new Set();
    const letterList = [...new Set(letters)];
    const wordList = Object.keys(mapping);

    function backtrack(index) {
        if (index === letterList.length) {
            return checkValid();
        }

        const letter = letterList[index];
        for (let digit = 0; digit <= 9; digit++) {
            if (usedDigits.has(digit)) continue;
            if (digit === 0 && isLeadingLetter(letter)) continue;

            letterToDigit[letter] = digit;
            usedDigits.add(digit);

            if (backtrack(index + 1)) {
                return true;
            }

            usedDigits.delete(digit);
            delete letterToDigit[letter];
        }

        return false;
    }

    function isLeadingLetter(letter) {
        return wordList.some(word => word[0] === letter);
    }

    function checkValid() {
        const sum = {};
        for (const word of wordList) {
            let value = 0;
            for (const c of word) {
                value = value * 10 + letterToDigit[c];
            }
            sum[word] = value;
        }

        let total = 0;
        for (const word of wordList) {
            if (word === wordList[wordList.length - 1]) continue;
            total += sum[word];
        }

        return total === sum[wordList[wordList.length - 1]];
    }

    return backtrack(0);
}