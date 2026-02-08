var countCharacters = function(words, chars) {
    let count = 0;
    const charCounts = {};
    for (let char of chars) {
        charCounts[char] = (charCounts[char] || 0) + 1;
    }

    for (let word of words) {
        const wordCounts = {};
        let good = true;
        for (let char of word) {
            wordCounts[char] = (wordCounts[char] || 0) + 1;
            if (!charCounts[char] || wordCounts[char] > charCounts[char]) {
                good = false;
                break;
            }
        }
        if (good) {
            count += word.length;
        }
    }

    return count;
};