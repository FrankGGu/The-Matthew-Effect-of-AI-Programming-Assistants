function sumOfGoodNumbers(n) {
    let result = 0;
    for (let i = 1; i <= n; i++) {
        let isGood = true;
        let digits = new Set();
        let num = i;
        while (num > 0) {
            let digit = num % 10;
            if (digits.has(digit)) {
                isGood = false;
                break;
            }
            digits.add(digit);
            num = Math.floor(num / 10);
        }
        if (isGood) {
            result += i;
        }
    }
    return result;
}