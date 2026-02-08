var replaceWords = function(dictionary, sentence) {
    const rootSet = new Set(dictionary);
    const words = sentence.split(' ');

    const findRoot = word => {
        for (let i = 1; i <= word.length; i++) {
            if (rootSet.has(word.slice(0, i))) {
                return word.slice(0, i);
            }
        }
        return word;
    };

    return words.map(findRoot).join(' ');
};