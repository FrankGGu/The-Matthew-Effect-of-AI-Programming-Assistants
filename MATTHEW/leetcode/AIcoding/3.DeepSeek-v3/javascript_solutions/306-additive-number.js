var isAdditiveNumber = function(num) {
    const n = num.length;
    for (let i = 1; i <= Math.floor(n / 2); i++) {
        for (let j = 1; Math.max(i, j) <= n - i - j; j++) {
            if (isValid(i, j, num)) {
                return true;
            }
        }
    }
    return false;
};

function isValid(i, j, num) {
    if (num[0] === '0' && i > 1) return false;
    if (num[i] === '0' && j > 1) return false;
    let sum;
    let x1 = BigInt(num.substring(0, i));
    let x2 = BigInt(num.substring(i, i + j));
    let start = i + j;
    while (start < num.length) {
        x2 = x1 + x2;
        x1 = x2 - x1;
        sum = x2.toString();
        if (!num.startsWith(sum, start)) {
            return false;
        }
        start += sum.length;
    }
    return true;
}