var removeDigit = function(number, digit) {
    let max = "";
    for (let i = 0; i < number.length; i++) {
        if (number[i] === digit) {
            const current = number.substring(0, i) + number.substring(i + 1);
            if (current > max) {
                max = current;
            }
        }
    }
    return max;
};