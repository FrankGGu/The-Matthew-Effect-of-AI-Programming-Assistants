function reversePrefix(word, ch) {
    const index = word.indexOf(ch);
    if (index === -1) return word;
    const prefix = word.slice(0, index + 1);
    const reversed = prefix.split('').reverse().join('');
    return reversed + word.slice(index + 1);
}