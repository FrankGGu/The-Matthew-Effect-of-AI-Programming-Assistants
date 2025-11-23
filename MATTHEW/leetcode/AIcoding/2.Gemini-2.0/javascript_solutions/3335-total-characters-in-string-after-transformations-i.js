var totalCharacters = function(words) {
    let count = 0;
    for (let word of words) {
        count += word.length;
    }
    return count;
};