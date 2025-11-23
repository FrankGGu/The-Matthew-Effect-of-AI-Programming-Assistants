var removeDigit = function(number, digit) {
    let maxResult = "";

    for (let i = 0; i < number.length; i++) {
        if (number[i] === digit) {
            const currentNumber = number.substring(0, i) + number.substring(i + 1);
            if (maxResult === "" || currentNumber > maxResult) {
                maxResult = currentNumber;
            }
        }
    }

    return maxResult;
};