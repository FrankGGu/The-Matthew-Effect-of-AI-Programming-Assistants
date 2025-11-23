function minAddToMakeIntegerBeautiful(num, target) {
    const digits = [];
    let n = num;
    while (n > 0) {
        digits.push(n % 10);
        n = Math.floor(n / 10);
    }

    let result = 0;
    let carry = 0;
    for (let i = 0; i < digits.length; i++) {
        const currentDigit = digits[i] + carry;
        const targetDigit = (target / Math.pow(10, i)) % 10;

        if (currentDigit < targetDigit) {
            const add = (10 - currentDigit + targetDigit) % 10;
            result += add * Math.pow(10, i);
            carry = 1;
        } else if (currentDigit > targetDigit) {
            carry = 0;
        } else {
            carry = 0;
        }
    }

    return result;
}