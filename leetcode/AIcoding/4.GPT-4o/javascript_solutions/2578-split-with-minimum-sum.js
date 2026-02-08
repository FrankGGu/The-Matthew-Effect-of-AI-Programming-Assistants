function splitNum(num) {
    let digits = Array.from(String(num)).map(Number).sort((a, b) => a - b);
    let num1 = '', num2 = '';

    for (let i = 0; i < digits.length; i++) {
        if (i % 2 === 0) {
            num1 += digits[i];
        } else {
            num2 += digits[i];
        }
    }

    return Number(num1) + Number(num2);
}