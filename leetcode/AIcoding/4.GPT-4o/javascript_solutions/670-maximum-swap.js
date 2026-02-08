var maximumSwap = function(num) {
    let digits = num.toString().split('');
    let lastIndex = Array(10).fill(-1);

    for (let i = 0; i < digits.length; i++) {
        lastIndex[digits[i]] = i;
    }

    for (let i = 0; i < digits.length; i++) {
        for (let d = 9; d > digits[i]; d--) {
            if (lastIndex[d] > i) {
                [digits[i], digits[lastIndex[d]]] = [digits[lastIndex[d]], digits[i]];
                return parseInt(digits.join(''));
            }
        }
    }

    return num;
};