var toGoatLatin = function(S) {
    const vowels = 'aeiouAEIOU';
    return S.split(' ').map((word, i) => {
        let goatWord = '';
        if (vowels.includes(word[0])) {
            goatWord = word + 'ma';
        } else {
            goatWord = word.slice(1) + word[0] + 'ma';
        }
        return goatWord + 'a'.repeat(i + 1);
    }).join(' ');
};