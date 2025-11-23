var toGoatLatin = function(sentence) {
    const vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
    const words = sentence.split(' ');
    let result = [];
    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        if (vowels.includes(word[0])) {
            word += 'ma';
        } else {
            word = word.slice(1) + word[0] + 'ma';
        }
        word += 'a'.repeat(i + 1);
        result.push(word);
    }
    return result.join(' ');
};