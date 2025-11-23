function removeDigitFromNumberToMaximizeResult(number, digit) {
    let maxResult = '';
    for (let i = 0; i < number.length; i++) {
        if (number[i] === digit) {
            const newNumber = number.substring(0, i) + number.substring(i + 1);
            if (newNumber > maxResult) {
                maxResult = newNumber;
            }
        }
    }
    return maxResult;
}