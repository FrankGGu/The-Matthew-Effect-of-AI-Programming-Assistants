var parseBoolExpr = function(expression) {
    function evaluate(expr) {
        if (expr === "t") return true;
        if (expr === "f") return false;

        let stack = [];
        let operator = '';
        let i = 0;

        if (expr[0] === '!') {
            operator = '!';
            i = 2; // skip "!("
        } else {
            operator = expr[0];
            i = 2; // skip "x("
        }

        while (i < expr.length) {
            if (expr[i] === 't' || expr[i] === 'f') {
                stack.push(expr[i] === 't');
                i++;
            } else if (expr[i] === '(') {
                let parenCount = 1;
                let start = i + 1;
                while (parenCount > 0) {
                    i++;
                    if (expr[i] === '(') parenCount++;
                    if (expr[i] === ')') parenCount--;
                }
                stack.push(evaluate(expr.slice(start, i)));
                i++;
            } else {
                i++;
            }
        }

        if (operator === '&') return stack.every(Boolean);
        if (operator === '|') return stack.some(Boolean);
        if (operator === '!') return !stack[0];
    }

    return evaluate(expression);
};