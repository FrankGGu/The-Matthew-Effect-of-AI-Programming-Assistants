var reversePrefix = function(word, ch) {
    const index = word.indexOf(ch);
    if (index === -1) return word;
    const prefix = word.slice(0, index + 1).split('').reverse().join('');
    return prefix + word.slice(index + 1);
};