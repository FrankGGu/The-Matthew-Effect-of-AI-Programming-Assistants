function sortVowels(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    let vowelsList = [];
    let result = s.split('');

    for (let i = 0; i < s.length; i++) {
        if (vowels.has(s[i])) {
            vowelsList.push(s[i]);
        }
    }

    vowelsList.sort();

    let vowelIndex = 0;
    for (let i = 0; i < s.length; i++) {
        if (vowels.has(s[i])) {
            result[i] = vowelsList[vowelIndex];
            vowelIndex++;
        }
    }

    return result.join('');
}