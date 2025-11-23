var minimumLengthEncoding = function(words) {
    let wordSet = new Set(words);

    for (let word of words) {
        for (let i = 1; i < word.length; i++) {
            let suffix = word.substring(i);
            if (wordSet.has(suffix)) {
                wordSet.delete(suffix);
            }
        }
    }

    let totalLength = 0;
    for (let word of wordSet) {
        totalLength += word.length + 1;
    }

    return totalLength;
};