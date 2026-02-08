var isSolvable = function(words, result) {
    const allWords = words.concat([result]);
    const firstChars = new Set();
    const charCounts = {};

    for (const word of allWords) {
        for (let i = 0; i < word.length; i++) {
            const c = word[i];
            if (i === 0 && word.length > 1) {
                firstChars.add(c);
            }
            charCounts[c] = (charCounts[c] || 0) + Math.pow(10, word.length - 1 - i);
        }
    }

    const chars = Object.keys(charCounts);
    const leadingChars = Array.from(firstChars);
    const n = chars.length;
    const usedDigits = new Array(10).fill(false);

    const backtrack = (index, sum) => {
        if (index === n) {
            return sum === 0;
        }

        const c = chars[index];
        const isLeading = leadingChars.includes(c);

        for (let d = isLeading ? 1 : 0; d <= 9; d++) {
            if (!usedDigits[d]) {
                usedDigits[d] = true;
                const newSum = sum + charCounts[c] * d;
                if (backtrack(index + 1, newSum)) {
                    return true;
                }
                usedDigits[d] = false;
            }
        }
        return false;
    };

    return backtrack(0, 0);
};