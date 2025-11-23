function deleteDigit(number, digit) {
    let maxResult = 0;
    for (let i = 0; i < number.length; i++) {
        if (number[i] === digit) {
            const newNumber = number.slice(0, i) + number.slice(i + 1);
            maxResult = Math.max(maxResult, parseInt(newNumber, 10));
        }
    }
    return maxResult;
}