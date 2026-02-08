var reformat = function(s) {
    let digits = [];
    let letters = [];

    for (let char of s) {
        if (isNaN(parseInt(char))) {
            letters.push(char);
        } else {
            digits.push(char);
        }
    }

    if (Math.abs(digits.length - letters.length) > 1) {
        return "";
    }

    let result = "";
    let longer = digits.length > letters.length ? digits : letters;
    let shorter = digits.length > letters.length ? letters : digits;

    for (let i = 0; i < shorter.length; i++) {
        result += longer[i];
        result += shorter[i];
    }

    if (longer.length > shorter.length) {
        result += longer[longer.length - 1];
    }

    return result;
};