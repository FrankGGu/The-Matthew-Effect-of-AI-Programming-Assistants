function calculate(s) {
    const stack = [];
    let currentNumber = 0;
    let operation = '+';

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (/\d/.test(char)) {
            currentNumber = currentNumber * 10 + parseInt(char);
        }

        if (char === ' ' || i === s.length - 1) {
            continue;
        }

        if (char in {'+': 1, '-': 1, '*': 1, '/': 1}) {
            if (operation === '+') {
                stack.push(currentNumber);
            } else if (operation === '-') {
                stack.push(-currentNumber);
            } else if (operation === '*') {
                stack.push(stack.pop() * currentNumber);
            } else if (operation === '/') {
                stack.push(Math.trunc(stack.pop() / currentNumber));
            }
            operation = char;
            currentNumber = 0;
        }
    }

    return stack.reduce((a, b) => a + b, 0);
}