var evalRPN = function(tokens) {
    const stack = [];
    const operators = new Set(['+', '-', '*', '/']);

    for (const token of tokens) {
        if (!operators.has(token)) {
            stack.push(parseInt(token));
        } else {
            const b = stack.pop();
            const a = stack.pop();
            let result;
            switch (token) {
                case '+':
                    result = a + b;
                    break;
                case '-':
                    result = a - b;
                    break;
                case '*':
                    result = a * b;
                    break;
                case '/':
                    result = (a / b) < 0 ? Math.ceil(a / b) : Math.floor(a / b);
                    break;
            }
            stack.push(result);
        }
    }
    return stack.pop();
};