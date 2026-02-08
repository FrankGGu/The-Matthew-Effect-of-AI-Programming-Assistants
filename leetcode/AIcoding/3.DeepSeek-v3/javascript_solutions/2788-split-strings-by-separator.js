var splitWordsBySeparator = function(words, separator) {
    let result = [];
    for (let word of words) {
        let parts = word.split(separator);
        for (let part of parts) {
            if (part !== "") {
                result.push(part);
            }
        }
    }
    return result;
};