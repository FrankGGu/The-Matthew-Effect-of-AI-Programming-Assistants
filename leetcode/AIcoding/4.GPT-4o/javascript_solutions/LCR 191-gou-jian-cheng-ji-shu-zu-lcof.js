function calculate(s) {
    const stack = [];
    let currentNumber = 0;
    let result = 0;
    let sign = 1; // 1 for '+', -1 for '-'

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (!isNaN(char)) {
            currentNumber = currentNumber * 10 + Number(char);
        }

        if (char === '+') {
            result += sign * currentNumber;
            currentNumber = 0;
            sign = 1;
        } else if (char === '-') {
            result += sign * currentNumber;
            currentNumber = 0;
            sign = -1;
        } else if (char === '(') {
            stack.push(result);
            stack.push(sign);
            result = 0;
            sign = 1;
        } else if (char === ')') {
            result += sign * currentNumber;
            currentNumber = 0;
            result *= stack.pop(); // sign before the parentheses
            result += stack.pop(); // result before the parentheses
        }
    }

    result += sign * currentNumber;
    return result;
}