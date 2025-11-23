var evalRPN = function(tokens) {
    const stack = [];

    for (const token of tokens) {
        if (token === "+") {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            stack.push(operand1 + operand2);
        } else if (token === "-") {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            stack.push(operand1 - operand2);
        } else if (token === "*") {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            stack.push(operand1 * operand2);
        } else if (token === "/") {
            const operand2 = stack.pop();
            const operand1 = stack.pop();
            stack.push(Math.trunc(operand1 / operand2));
        } else {
            stack.push(parseInt(token));
        }
    }

    return stack.pop();
};