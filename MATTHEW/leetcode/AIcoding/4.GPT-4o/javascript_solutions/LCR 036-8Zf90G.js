function evalRPN(tokens) {
    const stack = [];
    const operators = new Set(['+', '-', '*', '/']);

    for (const token of tokens) {
        if (operators.has(token)) {
            const b = stack.pop();
            const a = stack.pop();
            let result;
            if (token === '+') result = a + b;
            else if (token === '-') result = a - b;
            else if (token === '*') result = a * b;
            else result = Math.trunc(a / b);
            stack.push(result);
        } else {
            stack.push(parseInt(token));
        }
    }
    return stack[0];
}