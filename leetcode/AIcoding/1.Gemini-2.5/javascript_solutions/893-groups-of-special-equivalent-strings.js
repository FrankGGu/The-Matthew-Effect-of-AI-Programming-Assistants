var numSpecialEquivGroups = function(words) {
    const uniqueSignatures = new Set();

    for (const word of words) {
        const evenChars = [];
        const oddChars = [];

        for (let i = 0; i < word.length; i++) {
            if (i % 2 === 0) {
                evenChars.push(word[i]);
            } else {
                oddChars.push(word[i]);
            }
        }

        evenChars.sort();
        oddChars.sort();

        const signature = evenChars.join('') + '-' + oddChars.join('');
        uniqueSignatures.add(signature);
    }

    return uniqueSignatures.size;
};