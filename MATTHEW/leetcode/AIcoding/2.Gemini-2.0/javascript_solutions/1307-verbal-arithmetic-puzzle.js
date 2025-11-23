var isSolvable = function(words, result) {
    const chars = new Set();
    for (const word of words) {
        for (const char of word) {
            chars.add(char);
        }
    }
    for (const char of result) {
        chars.add(char);
    }
    const charArray = Array.from(chars);
    const n = charArray.length;
    const assignment = new Map();
    const used = new Set();

    const isLeadingZero = (word) => {
        if (word.length > 1 && assignment.get(word[0]) === 0) {
            return true;
        }
        return false;
    };

    const calculateValue = (word) => {
        let value = 0;
        for (const char of word) {
            value = value * 10 + assignment.get(char);
        }
        return value;
    };

    const backtrack = (index) => {
        if (index === n) {
            let sum = 0;
            for (const word of words) {
                if (isLeadingZero(word)) return false;
                sum += calculateValue(word);
            }
            if (isLeadingZero(result)) return false;
            return sum === calculateValue(result);
        }

        const char = charArray[index];
        for (let digit = 0; digit <= 9; digit++) {
            if (!used.has(digit)) {
                assignment.set(char, digit);
                used.add(digit);
                if (backtrack(index + 1)) {
                    return true;
                }
                used.delete(digit);
                assignment.delete(char);
            }
        }

        return false;
    };

    return backtrack(0);
};