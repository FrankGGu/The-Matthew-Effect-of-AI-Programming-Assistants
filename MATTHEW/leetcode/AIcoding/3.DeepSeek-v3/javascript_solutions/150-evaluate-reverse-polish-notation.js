var evalRPN = function(tokens) {
    let stack = [];
    for (let token of tokens) {
        if (!isNaN(token)) {
            stack.push(parseInt(token));
        } else {
            let b = stack.pop();
            let a = stack.pop();
            if (token === '+') {
                stack.push(a + b);
            } else if (token === '-') {
                stack.push(a - b);
            } else if (token === '*') {
                stack.push(a * b);
            } else if (token === '/') {
                stack.push(Math.trunc(a / b));
            }
        }
    }
    return stack.pop();
};