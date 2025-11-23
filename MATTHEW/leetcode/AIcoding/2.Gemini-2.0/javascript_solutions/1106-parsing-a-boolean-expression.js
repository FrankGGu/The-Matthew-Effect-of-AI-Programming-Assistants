var parseBoolExpr = function(expression) {
    const stack = [];

    for (const char of expression) {
        if (char === ')') {
            let values = [];
            while (stack[stack.length - 1] !== '(') {
                values.push(stack.pop());
            }
            stack.pop(); // Pop '('
            const operator = stack.pop();

            let result;
            if (operator === '&') {
                result = values.every(val => val === 't');
            } else if (operator === '|') {
                result = values.some(val => val === 't');
            } else {
                result = values[0] === 't' ? 'f' : 't';
            }

            stack.push(result ? 't' : 'f');
        } else if (char !== ',') {
            stack.push(char);
        }
    }

    return stack[0] === 't';
};