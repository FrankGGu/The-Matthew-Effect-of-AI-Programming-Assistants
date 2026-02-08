var splitWordsBySeparator = function(words, separators) {
    const result = [];

    const escapedSeparators = separators.map(sep => {
        return sep.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    });

    const regexPattern = escapedSeparators.join('|');
    const splitterRegex = new RegExp(regexPattern);

    for (const word of words) {
        const parts = word.split(splitterRegex);
        for (const part of parts) {
            if (part !== '') {
                result.push(part);
            }
        }
    }

    return result;
};