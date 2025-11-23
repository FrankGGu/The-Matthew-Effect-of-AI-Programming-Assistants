var splitWordsBySeparator = function(words, separator) {
    const result = [];
    for (const word of words) {
        const parts = word.split(separator);
        for (const part of parts) {
            if (part !== "") {
                result.push(part);
            }
        }
    }
    return result;
};