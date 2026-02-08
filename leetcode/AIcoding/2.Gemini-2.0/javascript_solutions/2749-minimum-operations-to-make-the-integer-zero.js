var makeTheIntegerZero = function(num1, num2) {
    if (num2 >= 0 && num1 < num2) return -1;
    if (num2 < 0 && num1 < 0 && num1 > num2) return -1;

    if (num2 * 32 >= num1) {
        return -1;
    }

    for (let k = 1; k <= 35; k++) {
        let diff = num1 - num2 * k;
        let bits = diff.toString(2).split('').filter(bit => bit === '1').length;
        if (bits <= k && k <= diff) {
            return k;
        }
    }

    return -1;
};