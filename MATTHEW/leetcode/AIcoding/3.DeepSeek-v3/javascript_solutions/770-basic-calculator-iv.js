var basicCalculatorIV = function(expression, evalvars, evalints) {
    const evalMap = {};
    for (let i = 0; i < evalvars.length; i++) {
        evalMap[evalvars[i]] = evalints[i];
    }

    const tokens = tokenize(expression);
    const rpn = toRPN(tokens);
    const poly = evaluate(rpn, evalMap);

    const sorted = [...poly.entries()].sort((a, b) => {
        const varsA = a[0];
        const varsB = b[0];
        if (varsA.length !== varsB.length) {
            return varsB.length - varsA.length;
        }
        for (let i = 0; i < varsA.length; i++) {
            if (varsA[i] !== varsB[i]) {
                return varsA[i].localeCompare(varsB[i]);
            }
        }
        return 0;
    });

    const res = [];
    for (const [vars, coeff] of sorted) {
        if (coeff === 0) continue;
        const term = coeff + (vars.length ? '*' + vars.join('*') : '');
        res.push(term);
    }
    return res;
};

function tokenize(expr) {
    const tokens = [];
    let i = 0;
    while (i < expr.length) {
        if (expr[i] === ' ') {
            i++;
            continue;
        }
        if (expr[i] === '(' || expr[i] === ')' || expr[i] === '+' || expr[i] === '-' || expr[i] === '*') {
            tokens.push(expr[i]);
            i++;
            continue;
        }
        let j = i;
        while (j < expr.length && /[a-z0-9]/.test(expr[j])) {
            j++;
        }
        tokens.push(expr.substring(i, j));
        i = j;
    }
    return tokens;
}

function toRPN(tokens) {
    const precedence = {
        '+': 1,
        '-': 1,
        '*': 2
    };
    const output = [];
    const ops = [];
    for (const token of tokens) {
        if (token === '(') {
            ops.push(token);
        } else if (token === ')') {
            while (ops.length && ops[ops.length - 1] !== '(') {
                output.push(ops.pop());
            }
            ops.pop();
        } else if (token in precedence) {
            while (ops.length && ops[ops.length - 1] !== '(' && precedence[ops[ops.length - 1]] >= precedence[token]) {
                output.push(ops.pop());
            }
            ops.push(token);
        } else {
            output.push(token);
        }
    }
    while (ops.length) {
        output.push(ops.pop());
    }
    return output;
}

function evaluate(rpn, evalMap) {
    const stack = [];
    for (const token of rpn) {
        if (token === '+' || token === '-' || token === '*') {
            const b = stack.pop();
            const a = stack.pop();
            let res;
            if (token === '+') {
                res = add(a, b);
            } else if (token === '-') {
                res = subtract(a, b);
            } else {
                res = multiply(a, b);
            }
            stack.push(res);
        } else {
            let poly = new Map();
            if (token in evalMap) {
                poly.set([], evalMap[token]);
            } else if (/^\d+$/.test(token)) {
                poly.set([], parseInt(token, 10));
            } else {
                poly.set([token], 1);
            }
            stack.push(poly);
        }
    }
    return stack[0];
}

function add(a, b) {
    const res = new Map(a);
    for (const [vars, coeff] of b) {
        const key = [...vars].sort();
        res.set(key, (res.get(key) || 0) + coeff);
    }
    return res;
}

function subtract(a, b) {
    const res = new Map(a);
    for (const [vars, coeff] of b) {
        const key = [...vars].sort();
        res.set(key, (res.get(key) || 0) - coeff);
    }
    return res;
}

function multiply(a, b) {
    const res = new Map();
    for (const [varsA, coeffA] of a) {
        for (const [varsB, coeffB] of b) {
            const vars = [...varsA, ...varsB].sort();
            const key = vars;
            res.set(key, (res.get(key) || 0) + coeffA * coeffB);
        }
    }
    return res;
}