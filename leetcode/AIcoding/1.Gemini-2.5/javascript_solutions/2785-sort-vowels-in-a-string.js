var sortVowels = function(s) {
    const isVowel = (char) => {
        char = char.toLowerCase();
        return char === 'a' || char === 'e' || char === 'i' || char === 'o' || char === 'u';
    };

    const vowelsFound = [];
    for (let i = 0; i < s.length; i++) {
        if (isVowel(s[i])) {
            vowelsFound.push(s[i]);
        }
    }

    vowelsFound.sort(); 

    const result = [];
    let vowelIndex = 0;
    for (let i = 0; i < s.length; i++) {
        if (isVowel(s[i])) {
            result.push(vowelsFound[vowelIndex]);
            vowelIndex++;
        } else {
            result.push(s[i]);
        }
    }

    return result.join('');
};