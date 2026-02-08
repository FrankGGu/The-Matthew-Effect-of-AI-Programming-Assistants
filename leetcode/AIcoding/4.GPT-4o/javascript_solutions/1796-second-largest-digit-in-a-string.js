var secondHighest = function(s) {
    let digits = new Set();
    for (let char of s) {
        if (char >= '0' && char <= '9') {
            digits.add(char);
        }
    }
    digits = Array.from(digits).sort((a, b) => b - a);
    return digits.length < 2 ? -1 : parseInt(digits[1]);
};