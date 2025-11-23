var reverseOnlyLetters = function(s) {
    let letters = s.split('').filter(char => /[a-zA-Z]/.test(char));
    let result = '';
    let letterIndex = letters.length - 1;

    for (let i = 0; i < s.length; i++) {
        if (/[a-zA-Z]/.test(s[i])) {
            result += letters[letterIndex];
            letterIndex--;
        } else {
            result += s[i];
        }
    }

    return result;
};