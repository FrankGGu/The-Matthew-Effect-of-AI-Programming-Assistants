var sortVowels = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    let vowelIndices = [];
    let vowelChars = [];

    for (let i = 0; i < s.length; i++) {
        if (vowels.has(s[i])) {
            vowelIndices.push(i);
            vowelChars.push(s[i]);
        }
    }

    vowelChars.sort((a, b) => a.charCodeAt(0) - b.charCodeAt(0));

    let result = s.split('');
    for (let i = 0; i < vowelIndices.length; i++) {
        result[vowelIndices[i]] = vowelChars[i];
    }

    return result.join('');
};