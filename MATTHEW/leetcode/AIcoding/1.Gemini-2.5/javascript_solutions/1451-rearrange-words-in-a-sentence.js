var arrangeWords = function(text) {
    if (!text) {
        return "";
    }

    const words = text.toLowerCase().split(' ');

    const indexedWords = words.map((word, index) => ({ word, index }));

    indexedWords.sort((a, b) => {
        if (a.word.length !== b.word.length) {
            return a.word.length - b.word.length;
        }
        return a.index - b.index;
    });

    const sortedWords = indexedWords.map(item => item.word);

    let result = sortedWords.join(' ');

    if (result.length > 0) {
        result = result.charAt(0).toUpperCase() + result.slice(1);
    }

    return result;
};