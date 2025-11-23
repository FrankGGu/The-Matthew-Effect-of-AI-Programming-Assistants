var minimumLengthEncoding = function(words) {
    let set = new Set(words);
    for (let word of words) {
        for (let i = 1; i < word.length; i++) {
            set.delete(word.substring(i));
        }
    }
    let result = 0;
    set.forEach(word => {
        result += word.length + 1;
    });
    return result;
};