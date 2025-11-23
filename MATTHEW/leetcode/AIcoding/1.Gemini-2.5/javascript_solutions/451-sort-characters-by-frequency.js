var frequencySort = function(s) {
    const charCounts = new Map();
    for (const char of s) {
        charCounts.set(char, (charCounts.get(char) || 0) + 1);
    }

    const sortedChars = Array.from(charCounts.entries()).sort((a, b) => b[1] - a[1]);

    let result = '';
    for (const [char, count] of sortedChars) {
        result += char.repeat(count);
    }

    return result;
};