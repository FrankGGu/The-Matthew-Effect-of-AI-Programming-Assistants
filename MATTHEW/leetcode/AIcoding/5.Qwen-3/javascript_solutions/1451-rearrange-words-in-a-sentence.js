var arrangeWords = function(sentence) {
    const words = sentence.split(' ');
    const firstWord = words[0].toLowerCase();
    words[0] = firstWord;
    words.sort((a, b) => a.length - b.length);
    return words.join(' ').charAt(0).toUpperCase() + words.join(' ').slice(1);
};