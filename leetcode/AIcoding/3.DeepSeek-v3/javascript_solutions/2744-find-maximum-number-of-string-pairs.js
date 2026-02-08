var maximumNumberOfStringPairs = function(words) {
    let count = 0;
    const seen = new Set();

    for (const word of words) {
        const reversed = word.split('').reverse().join('');
        if (seen.has(reversed)) {
            count++;
            seen.delete(reversed);
        } else {
            seen.add(word);
        }
    }

    return count;
};