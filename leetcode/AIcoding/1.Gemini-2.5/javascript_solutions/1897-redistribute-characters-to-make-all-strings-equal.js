var makeEqual = function(words) {
    const n = words.length;
    if (n === 1) {
        return true;
    }

    const charCounts = new Array(26).fill(0);

    for (const word of words) {
        for (let i = 0; i < word.length; i++) {
            charCounts[word.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        }
    }

    for (let i = 0; i < 26; i++) {
        if (charCounts[i] % n !== 0) {
            return false;
        }
    }

    return true;
};