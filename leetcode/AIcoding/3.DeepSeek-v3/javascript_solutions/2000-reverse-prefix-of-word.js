var reversePrefix = function(word, ch) {
    const index = word.indexOf(ch);
    if (index === -1) return word;
    const prefix = word.substring(0, index + 1);
    const reversed = prefix.split('').reverse().join('');
    return reversed + word.substring(index + 1);
};