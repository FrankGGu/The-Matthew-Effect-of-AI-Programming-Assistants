var isValid = function(word) {
    if (word.length < 3) {
        return false;
    }
    let hasVowel = false;
    let hasConsonant = false;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const validChars = new Set(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);

    for (const char of word) {
        if (!validChars.has(char)) {
            return false;
        }
        if (vowels.has(char)) {
            hasVowel = true;
        } else if (/^[a-zA-Z]$/.test(char)) {
            hasConsonant = true;
        }
    }

    return hasVowel && hasConsonant;
};