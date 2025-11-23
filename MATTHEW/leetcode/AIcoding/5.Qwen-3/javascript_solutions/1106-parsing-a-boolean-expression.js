function parseBoolExpr(expression) {
    const stack = [];
    const ops = new Set(['&', '|', '!']);

    for (const c of expression) {
        if (c === '(' || c === ',' || c === ' ') continue;
        if (c === 't') stack.push(true);
        else if (c === 'f') stack.push(false);
        else if (ops.has(c)) {
            stack.push(c);
        } else if (c === ')') {
            let expr = [];
            while (stack[stack.length - 1] !== '(') {
                expr.push(stack.pop());
            }
            stack.pop(); // remove '('
            const op = stack.pop();
            let result;
            if (op === '&') {
                result = expr.every(Boolean);
            } else if (op === '|') {
                result = expr.some(Boolean);
            } else if (op === '!') {
                result = !expr[0];
            }
            stack.push(result);
        }
    }

    return stack[0];
}