var isAdditiveNumber = function(num) {
    const n = num.length;

    function isValid(prev1, prev2, index) {
        if (index === n) {
            return true;
        }

        const sum = prev1 + prev2;
        const sumStr = sum.toString();

        if (index + sumStr.length > n) {
            return false;
        }

        if (num.substring(index, index + sumStr.length) === sumStr) {
            return isValid(prev2, sum, index + sumStr.length);
        }

        return false;
    }

    for (let i = 1; i <= n - 2; i++) {
        if (num[0] === '0' && i > 1) {
            break;
        }
        const num1Str = num.substring(0, i);
        const num1 = BigInt(num1Str);

        for (let j = 1; i + j <= n - 1; j++) {
            if (num[i] === '0' && j > 1) {
                break;
            }
            const num2Str = num.substring(i, i + j);
            const num2 = BigInt(num2Str);

            if (isValid(num1, num2, i + j)) {
                return true;
            }
        }
    }

    return false;
};