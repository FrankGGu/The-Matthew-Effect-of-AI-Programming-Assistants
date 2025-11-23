var rotatedDigits = function(n) {
    let count = 0;

    for (let i = 1; i <= n; i++) {
        let num = i;
        let hasInvalidDigit = false;
        let hasRotatingDigit = false;

        while (num > 0) {
            let digit = num % 10;
            if (digit === 3 || digit === 4 || digit === 7) {
                hasInvalidDigit = true;
                break;
            }
            if (digit === 2 || digit === 5 || digit === 6 || digit === 9) {
                hasRotatingDigit = true;
            }
            num = Math.floor(num / 10);
        }

        if (!hasInvalidDigit && hasRotatingDigit) {
            count++;
        }
    }

    return count;
};