var isValid = function(word) {
    if (word.length < 3) {
        return false;
    }

    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let hasVowel = false;
    let hasConsonant = false;

    for (let i = 0; i < word.length; i++) {
        const char = word[i];
        const charCode = char.charCodeAt(0);

        const isDigit = charCode >= 48 && charCode <= 57;
        const isUpperCaseLetter = charCode >= 65 && charCode <= 90;
        const isLowerCaseLetter = charCode >= 97 && charCode <= 122;

        if (!isDigit && !isUpperCaseLetter && !isLowerCaseLetter) {
            return false;
        }

        if (isUpperCaseLetter || isLowerCaseLetter) {
            const lowerChar = char.toLowerCase();
            if (vowels.has(lowerChar)) {
                hasVowel = true;
            } else {
                hasConsonant = true;
            }
        }
    }

    return hasVowel && hasConsonant;
};