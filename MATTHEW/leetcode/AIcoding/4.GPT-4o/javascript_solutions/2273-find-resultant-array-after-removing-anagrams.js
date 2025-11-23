var removeAnagrams = function(words) {
    const result = [];
    let lastSorted = '';

    for (const word of words) {
        const sortedWord = word.split('').sort().join('');
        if (sortedWord !== lastSorted) {
            result.push(word);
            lastSorted = sortedWord;
        }
    }

    return result;
};