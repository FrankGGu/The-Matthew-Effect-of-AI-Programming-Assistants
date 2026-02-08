function reformat(s) {
    let letters = [];
    let digits = [];

    for (let char of s) {
        if (isNaN(char)) {
            letters.push(char);
        } else {
            digits.push(char);
        }
    }

    if (Math.abs(letters.length - digits.length) > 1) {
        return "";
    }

    let result = [];
    let longArray = letters.length > digits.length ? letters : digits;
    let shortArray = letters.length > digits.length ? digits : letters;

    for (let i = 0; i < longArray.length; i++) {
        result.push(longArray[i]);
        if (i < shortArray.length) {
            result.push(shortArray[i]);
        }
    }

    return result.join('');
}