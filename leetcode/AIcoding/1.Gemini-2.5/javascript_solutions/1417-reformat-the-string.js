var reformat = function(s) {
    let digits = [];
    let letters = [];

    for (let char of s) {
        if (char >= '0' && char <= '9') {
            digits.push(char);
        } else {
            letters.push(char);
        }
    }

    if (Math.abs(digits.length - letters.length) > 1) {
        return "";
    }

    let result = [];
    let i = 0; // pointer for letters
    let j = 0; // pointer for digits

    let startWithLetter = letters.length >= digits.length;

    if (startWithLetter) {
        while (i < letters.length || j < digits.length) {
            if (i < letters.length) {
                result.push(letters[i++]);
            }
            if (j < digits.length) {
                result.push(digits[j++]);
            }
        }
    } else { // start with digit
        while (i < letters.length || j < digits.length) {
            if (j < digits.length) {
                result.push(digits[j++]);
            }
            if (i < letters.length) {
                result.push(letters[i++]);
            }
        }
    }

    return result.join('');
};