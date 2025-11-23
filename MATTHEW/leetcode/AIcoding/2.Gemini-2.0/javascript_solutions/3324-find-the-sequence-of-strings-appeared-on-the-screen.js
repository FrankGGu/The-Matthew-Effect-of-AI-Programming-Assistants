var findWords = function(s) {
    const words = s.split('#');
    const result = [];
    for (let i = 0; i < words.length; i++) {
        if (words[i] !== '') {
            result.push(words[i]);
        }
    }
    return result;
};