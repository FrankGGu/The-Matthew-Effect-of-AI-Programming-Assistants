var alternatingDigitSum = function(n) {
    let s = String(n);
    let sum = 0;
    for (let i = 0; i < s.length; i++) {
        let digit = parseInt(s[i]);
        if (i % 2 === 0) {
            sum += digit;
        } else {
            sum -= digit;
        }
    }
    return sum;
};