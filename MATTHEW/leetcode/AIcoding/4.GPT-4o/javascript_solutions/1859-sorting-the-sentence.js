var sortSentence = function(s) {
    let words = s.split(' ');
    let sorted = new Array(words.length);
    for (let word of words) {
        let index = parseInt(word[word.length - 1]) - 1;
        sorted[index] = word.slice(0, word.length - 1);
    }
    return sorted.join(' ');
};