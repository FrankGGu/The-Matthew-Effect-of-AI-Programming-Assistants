var maximumSwap = function(num) {
    const digits = num.toString().split('');
    const lastOccurrence = new Array(10).fill(-1);

    for (let i = 0; i < digits.length; i++) {
        lastOccurrence[parseInt(digits[i])] = i;
    }

    for (let i = 0; i < digits.length; i++) {
        const currentDigit = parseInt(digits[i]);
        for (let d = 9; d > currentDigit; d--) {
            if (lastOccurrence[d] > i) {
                [digits[i], digits[lastOccurrence[d]]] = [digits[lastOccurrence[d]], digits[i]];
                return parseInt(digits.join(''));
            }
        }
    }

    return num;
};