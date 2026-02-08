var replaceWords = function(dictionary, sentence) {
    const dict = new Set(dictionary);
    const words = sentence.split(' ');
    const result = [];

    for (const word of words) {
        let root = '';
        for (let i = 1; i <= word.length; i++) {
            const prefix = word.substring(0, i);
            if (dict.has(prefix)) {
                root = prefix;
                break;
            }
        }
        result.push(root || word);
    }

    return result.join(' ');
};