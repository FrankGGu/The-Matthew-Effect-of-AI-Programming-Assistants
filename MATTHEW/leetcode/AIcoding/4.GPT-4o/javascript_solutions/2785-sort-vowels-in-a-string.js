var sortVowels = function(s) {
    const vowels = 'aeiouAEIOU';
    const vowelChars = [];

    for (let char of s) {
        if (vowels.includes(char)) {
            vowelChars.push(char);
        }
    }

    vowelChars.sort((a, b) => a.localeCompare(b));

    let vowelIndex = 0;
    const result = [];

    for (let char of s) {
        if (vowels.includes(char)) {
            result.push(vowelChars[vowelIndex++]);
        } else {
            result.push(char);
        }
    }

    return result.join('');
};