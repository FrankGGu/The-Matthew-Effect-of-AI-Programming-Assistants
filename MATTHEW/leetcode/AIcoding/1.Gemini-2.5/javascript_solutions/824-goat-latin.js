var toGoatLatin = function(sentence) {
    const words = sentence.split(' ');
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const result = [];

    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        let firstChar = word[0];
        let modifiedWord = '';

        if (vowels.has(firstChar.toLowerCase())) {
            modifiedWord = word + 'ma';
        } else {
            modifiedWord = word.substring(1) + firstChar + 'ma';
        }

        modifiedWord += 'a'.repeat(i + 1);
        result.push(modifiedWord);
    }

    return result.join(' ');
};