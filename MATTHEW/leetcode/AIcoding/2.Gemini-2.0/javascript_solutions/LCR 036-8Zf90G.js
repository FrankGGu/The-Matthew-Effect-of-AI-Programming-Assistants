var evalRPN = function(tokens) {
    const stack = [];
    for (const token of tokens) {
        if (isNaN(token)) {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            let result;
            switch (token) {
                case '+':
                    result = operand1 + operand2;
                    break;
                case '-':
                    result = operand1 - operand2;
                    break;
                case '*':
                    result = operand1 * operand2;
                    break;
                case '/':
                    result = Math.trunc(operand1 / operand2);
                    break;
            }
            stack.push(result);
        } else {
            stack.push(parseInt(token));
        }
    }
    return stack[0];
};