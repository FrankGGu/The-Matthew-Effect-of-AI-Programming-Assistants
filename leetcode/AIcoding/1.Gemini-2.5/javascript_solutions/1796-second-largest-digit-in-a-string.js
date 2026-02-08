var secondLargest = function(s) {
    const digits = new Set();
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char >= '0' && char <= '9') {
            digits.add(parseInt(char));
        }
    }

    const uniqueDigits = Array.from(digits);
    uniqueDigits.sort((a, b) => b - a);

    if (uniqueDigits.length >= 2) {
        return uniqueDigits[1];
    } else {
        return -1;
    }
};