var fractionAddition = function(expression) {
    let num = 0, den = 1;
    let i = 0;
    while (i < expression.length) {
        let sign = 1;
        if (expression[i] === '+' || expression[i] === '-') {
            sign = expression[i] === '+' ? 1 : -1;
            i++;
        }
        let num1 = 0;
        while (i < expression.length && expression[i] >= '0' && expression[i] <= '9') {
            num1 = num1 * 10 + (expression[i] - '0');
            i++;
        }
        i++;
        let den1 = 0;
        while (i < expression.length && expression[i] >= '0' && expression[i] <= '9') {
            den1 = den1 * 10 + (expression[i] - '0');
            i++;
        }
        num1 *= sign;
        let newNum = num * den1 + num1 * den;
        let newDen = den * den1;
        let gcd = (a, b) => {
            return b === 0 ? a : gcd(b, a % b);
        }
        let common = gcd(Math.abs(newNum), Math.abs(newDen));
        num = newNum / common;
        den = newDen / common;
    }
    return num + "/" + den;
};