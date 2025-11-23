var parse = function(expression) {
    const tokens = [];
    let i = 0;
    while (i < expression.length) {
        if (expression[i] === ' ') {
            i++;
        } else if (expression[i] === '(' || expression[i] === ')') {
            tokens.push(expression[i]);
            i++;
        } else if (expression[i] === '-') {
            tokens.push('-');
            i++;
        } else {
            let j = i;
            while (j < expression.length && (expression[j] === '-' || /[0-9]/.test(expression[j]))) {
                j++;
            }
            tokens.push(expression.substring(i, j));
            i = j;
        }
    }

    const stack = [];
    const env = [];

    function evaluate(expr) {
        if (typeof expr === 'number') return expr;
        if (expr[0] === ' ') {
            const vars = expr.slice(1);
            const values = [];
            for (let i = 0; i < vars.length; i += 2) {
                values.push(evaluate(vars[i + 1]));
            }
            env.push(values);
            const result = evaluate(vars[vars.length - 1]);
            env.pop();
            return result;
        } else {
            const vars = expr.slice(1);
            const values = [];
            for (let i = 0; i < vars.length; i += 2) {
                values.push(evaluate(vars[i + 1]));
            }
            env.push(values);
            const result = evaluate(vars[vars.length - 1]);
            env.pop();
            return result;
        }
    }

    function parseExpr() {
        const token = tokens.shift();
        if (token === '(') {
            const expr = [];
            while (tokens[0] !== ')') {
                expr.push(parseExpr());
            }
            tokens.shift(); // remove ')'
            return expr;
        } else if (token === ' ') {
            return parseExpr();
        } else {
            return token;
        }
    }

    const expr = parseExpr();
    return evaluate(expr);
};