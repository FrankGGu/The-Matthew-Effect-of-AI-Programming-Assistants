function reformat(s) {
    const letters = [];
    const digits = [];
    for (const c of s) {
        if (/[a-zA-Z]/.test(c)) {
            letters.push(c);
        } else {
            digits.push(c);
        }
    }
    if (Math.abs(letters.length - digits.length) > 1) {
        return "";
    }
    let result = [];
    let i = 0, j = 0;
    if (letters.length > digits.length) {
        while (i < letters.length || j < digits.length) {
            result.push(letters[i++]);
            if (j < digits.length) {
                result.push(digits[j++]);
            }
        }
    } else {
        while (i < letters.length || j < digits.length) {
            result.push(digits[j++]);
            if (i < letters.length) {
                result.push(letters[i++]);
            }
        }
    }
    return result.join("");
}