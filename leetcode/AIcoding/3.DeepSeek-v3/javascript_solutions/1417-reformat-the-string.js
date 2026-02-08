var reformat = function(s) {
    let letters = [];
    let digits = [];

    for (let c of s) {
        if (isNaN(c)) {
            letters.push(c);
        } else {
            digits.push(c);
        }
    }

    if (Math.abs(letters.length - digits.length) > 1) {
        return "";
    }

    let res = [];
    let longer = letters.length > digits.length ? letters : digits;
    let shorter = letters.length > digits.length ? digits : letters;

    for (let i = 0; i < longer.length; i++) {
        res.push(longer[i]);
        if (i < shorter.length) {
            res.push(shorter[i]);
        }
    }

    return res.join('');
};