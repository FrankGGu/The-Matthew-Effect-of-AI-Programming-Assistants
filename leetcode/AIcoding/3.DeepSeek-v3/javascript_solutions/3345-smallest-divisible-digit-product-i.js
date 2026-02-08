var smallestDivisibleDigitProduct = function(n) {
    for (let num = 1; ; num++) {
        let product = 1;
        let temp = num;
        while (temp > 0) {
            const digit = temp % 10;
            if (digit === 0) {
                product = 0;
                break;
            }
            product *= digit;
            temp = Math.floor(temp / 10);
        }
        if (product !== 0 && num % product === 0 && product === n) {
            return num;
        }
    }
};