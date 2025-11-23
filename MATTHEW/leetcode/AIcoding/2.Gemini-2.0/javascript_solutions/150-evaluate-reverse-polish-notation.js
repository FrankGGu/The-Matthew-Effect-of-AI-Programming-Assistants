var evalRPN = function(tokens) {
    const stack = [];
    for (const token of tokens) {
        if (isNaN(token)) {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            switch (token) {
                case '+':
                    stack.push(operand1 + operand2);
                    break;
                case '-':
                    stack.push(operand1 - operand2);
                    break;
                case '*':
                    stack.push(operand1 * operand2);
                    break;
                case '/':
                    stack.push(Math.trunc(operand1 / operand2));
                    break;
            }
        } else {
            stack.push(parseInt(token));
        }
    }
    return stack[0];
};