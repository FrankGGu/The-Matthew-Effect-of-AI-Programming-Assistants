var reverse = function(x) {
    const sign = Math.sign(x);
    const absX = Math.abs(x);
    const reversedStr = String(absX).split('').reverse().join('');
    const reversedNum = Number(reversedStr);

    const result = sign * reversedNum;

    const MAX_INT = Math.pow(2, 31) - 1;
    const MIN_INT = -Math.pow(2, 31);

    if (result > MAX_INT || result < MIN_INT) {
        return 0;
    }

    return result;
};