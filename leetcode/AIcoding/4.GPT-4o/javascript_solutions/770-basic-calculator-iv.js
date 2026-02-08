var basicCalculatorIV = function(expression, evalvars, evalints) {
    const varsMap = new Map();
    for (let i = 0; i < evalvars.length; i++) {
        varsMap.set(evalvars[i], evalints[i]);
    }

    const parse = (expr) => {
        const tokens = expr.match(/(\d+|[a-zA-Z]+|[()*/+-])/g);
        const output = [];
        const stack = [];

        const precedence = (op) => op === '+' || op === '-' ? 1 : 2;

        for (const token of tokens) {
            if (!isNaN(token) || /^[a-zA-Z]+$/.test(token)) {
                output.push(token);
            } else if (token === '(') {
                stack.push(token);
            } else if (token === ')') {
                while (stack.length && stack[stack.length - 1] !== '(') {
                    output.push(stack.pop());
                }
                stack.pop();
            } else {
                while (stack.length && precedence(stack[stack.length - 1]) >= precedence(token)) {
                    output.push(stack.pop());
                }
                stack.push(token);
            }
        }

        while (stack.length) {
            output.push(stack.pop());
        }
        return output;
    };

    const evalRPN = (rpn) => {
        const stack = [];

        for (const token of rpn) {
            if (!isNaN(token)) {
                stack.push(parseInt(token));
            } else if (varsMap.has(token)) {
                stack.push(varsMap.get(token));
            } else {
                const b = stack.pop();
                const a = stack.pop();
                if (token === '+') stack.push(a + b);
                else if (token === '-') stack.push(a - b);
                else if (token === '*') stack.push(a * b);
                else if (token === '/') stack.push(Math.floor(a / b));
            }
        }
        return stack[0];
    };

    const rpn = parse(expression);
    return evalRPN(rpn);
};