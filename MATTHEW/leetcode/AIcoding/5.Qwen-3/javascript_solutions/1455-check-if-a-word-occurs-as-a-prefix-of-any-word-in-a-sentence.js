function isPrefixOfWord(sentence, word) {
    const words = sentence.split(' ');
    for (let i = 0; i < words.length; i++) {
        if (words[i].startsWith(word)) {
            return i + 1;
        }
    }
    return -1;
}