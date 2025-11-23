var reverseWords = function(s) {
    const words = s.split(' ');
    const reversedWords = words.map(word => {
        return word.split('').reverse().join('');
    });
    return reversedWords.join(' ');
};