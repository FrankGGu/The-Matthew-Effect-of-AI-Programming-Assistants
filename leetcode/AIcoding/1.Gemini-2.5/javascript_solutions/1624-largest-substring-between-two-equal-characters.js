var maxLengthBetweenEqualCharacters = function(s) {
    let maxLength = -1;
    const firstOccurrence = new Map();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (firstOccurrence.has(char)) {
            maxLength = Math.max(maxLength, i - firstOccurrence.get(char) - 1);
        } else {
            firstOccurrence.set(char, i);
        }
    }

    return maxLength;
};