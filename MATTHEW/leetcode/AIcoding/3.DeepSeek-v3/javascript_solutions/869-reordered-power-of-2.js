var reorderedPowerOf2 = function(n) {
    const countDigits = (num) => {
        const count = new Array(10).fill(0);
        while (num > 0) {
            const digit = num % 10;
            count[digit]++;
            num = Math.floor(num / 10);
        }
        return count.join('');
    };

    const powerOf2Digits = new Set();
    for (let i = 0; i < 31; i++) {
        const num = 1 << i;
        powerOf2Digits.add(countDigits(num));
    }

    const nDigits = countDigits(n);
    return powerOf2Digits.has(nDigits);
};