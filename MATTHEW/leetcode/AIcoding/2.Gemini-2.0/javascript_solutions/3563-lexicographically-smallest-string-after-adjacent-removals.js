var lastNonEmptyString = function(s) {
    const counts = new Array(26).fill(0);
    for (const char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const maxCount = Math.max(...counts);
    const result = [];
    for (const char of s) {
        if (counts[char.charCodeAt(0) - 'a'.charCodeAt(0)] === maxCount) {
            result.push(char);
            counts[char.charCodeAt(0) - 'a'.charCodeAt(0)] = -1;
        }
    }

    return result.join('');
};