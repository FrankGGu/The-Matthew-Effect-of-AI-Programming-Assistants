var largestInteger = function(num) {
    const digits = num.toString().split('').map(Number);
    const evens = [];
    const odds = [];
    const isEven = [];

    for (const digit of digits) {
        if (digit % 2 === 0) {
            evens.push(digit);
            isEven.push(true);
        } else {
            odds.push(digit);
            isEven.push(false);
        }
    }

    evens.sort((a, b) => b - a);
    odds.sort((a, b) => b - a);

    let evenPtr = 0;
    let oddPtr = 0;
    let result = [];

    for (const even of isEven) {
        if (even) {
            result.push(evens[evenPtr++]);
        } else {
            result.push(odds[oddPtr++]);
        }
    }

    return parseInt(result.join(''), 10);
};