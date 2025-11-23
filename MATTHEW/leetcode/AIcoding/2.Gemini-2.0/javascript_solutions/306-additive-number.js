var isAdditiveNumber = function(num) {
    const n = num.length;

    const isValid = (first, second, start) => {
        if (start === n) return true;

        const sum = String(BigInt(first) + BigInt(second));
        if (num.startsWith(sum, start)) {
            return isValid(second, sum, start + sum.length);
        }
        return false;
    };

    for (let i = 1; i <= Math.floor(n / 2); i++) {
        if (num[0] === '0' && i > 1) continue;

        for (let j = 1; Math.max(i, j) <= n - i - j; j++) {
            if (num[i] === '0' && j > 1) continue;

            if (isValid(num.substring(0, i), num.substring(i, i + j), i + j)) {
                return true;
            }
        }
    }

    return false;
};