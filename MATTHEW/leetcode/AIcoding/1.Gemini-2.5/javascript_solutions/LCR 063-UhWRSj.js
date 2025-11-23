var replaceWords = function(dictionary, sentence) {
    const rootSet = new Set(dictionary);
    const words = sentence.split(' ');
    const result = [];

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        let replaced = false;
        for (let j = 1; j <= word.length; j++) {
            const prefix = word.substring(0, j);
            if (rootSet.has(prefix)) {
                result.push(prefix);
                replaced = true;
                break;
            }
        }
        if (!replaced) {
            result.push(word);
        }
    }

    return result.join(' ');
};