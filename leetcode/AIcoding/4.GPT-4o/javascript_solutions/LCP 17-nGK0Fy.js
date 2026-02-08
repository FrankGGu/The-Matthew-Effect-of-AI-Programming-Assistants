var calculate = function(s) {
    let stack = [];
    let currentNumber = 0;
    let operation = '+';

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (/\d/.test(char)) {
            currentNumber = currentNumber * 10 + parseInt(char);
        }

        if (char === '+' || char === '-' || char === '*' || char === '/' || i === s.length - 1) {
            if (operation === '+') {
                stack.push(currentNumber);
            } else if (operation === '-') {
                stack.push(-currentNumber);
            } else if (operation === '*') {
                stack[stack.length - 1] *= currentNumber;
            } else if (operation === '/') {
                stack[stack.length - 1] = Math.trunc(stack[stack.length - 1] / currentNumber);
            }
            operation = char;
            currentNumber = 0;
        }
    }

    return stack.reduce((a, b) => a + b, 0);
};