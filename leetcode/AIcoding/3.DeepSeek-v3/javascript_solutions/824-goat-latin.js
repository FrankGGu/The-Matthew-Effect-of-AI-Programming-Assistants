var toGoatLatin = function(sentence) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const words = sentence.split(' ');
    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        if (!vowels.has(word[0])) {
            word = word.substring(1) + word[0];
        }
        word += 'ma' + 'a'.repeat(i + 1);
        words[i] = word;
    }
    return words.join(' ');
};