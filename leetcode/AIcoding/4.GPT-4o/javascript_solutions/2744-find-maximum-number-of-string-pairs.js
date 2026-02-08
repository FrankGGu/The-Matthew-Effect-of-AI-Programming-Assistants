function maximumNumberOfStringPairs(words) {
    const seen = new Set();
    let count = 0;

    for (const word of words) {
        const reversed = word.split('').reverse().join('');
        if (seen.has(reversed)) {
            count++;
        } else {
            seen.add(word);
        }
    }

    return count;
}