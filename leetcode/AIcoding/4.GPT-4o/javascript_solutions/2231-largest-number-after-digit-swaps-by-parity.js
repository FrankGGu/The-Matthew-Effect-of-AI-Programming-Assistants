var largestInteger = function(num) {
    const evenDigits = [];
    const oddDigits = [];

    for (let digit of String(num)) {
        digit = Number(digit);
        if (digit % 2 === 0) {
            evenDigits.push(digit);
        } else {
            oddDigits.push(digit);
        }
    }

    evenDigits.sort((a, b) => b - a);
    oddDigits.sort((a, b) => b - a);

    let result = '';
    for (let digit of String(num)) {
        digit = Number(digit);
        if (digit % 2 === 0) {
            result += evenDigits.shift();
        } else {
            result += oddDigits.shift();
        }
    }

    return Number(result);
};