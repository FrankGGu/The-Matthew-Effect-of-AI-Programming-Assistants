var evalRPN = function(tokens) {
    const stack = [];
    const operators = {
        '+': (a, b) => a + b,
        '-': (a, b) => a - b,
        '*': (a, b) => a * b,
        '/': (a, b) => Math.trunc(a / b)
    };

    for (const token of tokens) {
        if (operators[token]) {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            stack.push(operators[token](operand1, operand2));
        } else {
            stack.push(parseInt(token));
        }
    }

    return stack.pop();
};