var basicCalculatorIV = function(expression, evalvars, evalints) {
    let vars = {};
    for (let i = 0; i < evalvars.length; i++) {
        vars[evalvars[i]] = evalints[i];
    }

    function tokenize(s) {
        let tokens = [];
        let num = "";
        for (let i = 0; i < s.length; i++) {
            if (s[i] === ' ') {
                if (num !== "") {
                    tokens.push(num);
                    num = "";
                }
            } else if (s[i] === '+' || s[i] === '-' || s[i] === '*' || s[i] === '(' || s[i] === ')') {
                if (num !== "") {
                    tokens.push(num);
                    num = "";
                }
                tokens.push(s[i]);
            } else {
                num += s[i];
            }
        }
        if (num !== "") {
            tokens.push(num);
        }
        return tokens;
    }

    function evaluate(tokens) {
        let values = [];
        let ops = [];

        function operate() {
            let op = ops.pop();
            let v2 = values.pop();
            let v1 = values.pop();

            if (op === '+') {
                values.push(add(v1, v2));
            } else if (op === '-') {
                values.push(subtract(v1, v2));
            } else if (op === '*') {
                values.push(multiply(v1, v2));
            }
        }

        let precedence = {
            '+': 1,
            '-': 1,
            '*': 2
        };

        for (let token of tokens) {
            if (token === '(') {
                ops.push(token);
            } else if (token === ')') {
                while (ops[ops.length - 1] !== '(') {
                    operate();
                }
                ops.pop();
            } else if (token === '+' || token === '-' || token === '*') {
                while (ops.length > 0 && ops[ops.length - 1] !== '(' && precedence[token] <= precedence[ops[ops.length - 1]]) {
                    operate();
                }
                ops.push(token);
            } else {
                if (/^\d+$/.test(token)) {
                    values.push([[parseInt(token)], 0]);
                } else {
                    if (vars[token] !== undefined) {
                        values.push([[vars[token]], 0]);
                    } else {
                        values.push([[1], token]);
                    }
                }
            }
        }

        while (ops.length > 0) {
            operate();
        }

        return values[0];
    }

    function add(p1, p2) {
        let result = {};
        for (let term of p1[0]) {
            let coeff = term[0];
            let vars = term.slice(1).sort();
            let key = vars.join(',');
            result[key] = (result[key] || 0) + coeff;
        }
        for (let term of p2[0]) {
            let coeff = term[0];
            let vars = term.slice(1).sort();
            let key = vars.join(',');
            result[key] = (result[key] || 0) + coeff;
        }

        let resArray = [];
        for (let key in result) {
            if (result[key] !== 0) {
                let term = [result[key]];
                if (key !== "") {
                    term = term.concat(key.split(','));
                }
                resArray.push(term);
            }
        }
        return [resArray, 0];
    }

    function subtract(p1, p2) {
        let result = {};
        for (let term of p1[0]) {
            let coeff = term[0];
            let vars = term.slice(1).sort();
            let key = vars.join(',');
            result[key] = (result[key] || 0) + coeff;
        }
        for (let term of p2[0]) {
            let coeff = term[0];
            let vars = term.slice(1).sort();
            let key = vars.join(',');
            result[key] = (result[key] || 0) - coeff;
        }

        let resArray = [];
        for (let key in result) {
            if (result[key] !== 0) {
                let term = [result[key]];
                if (key !== "") {
                    term = term.concat(key.split(','));
                }
                resArray.push(term);
            }
        }
        return [resArray, 0];
    }

    function multiply(p1, p2) {
        let result = {};
        for (let term1 of p1[0]) {
            for (let term2 of p2[0]) {
                let coeff = term1[0] * term2[0];
                let vars1 = term1.slice(1);
                let vars2 = term2.slice(1);
                let vars = vars1.concat(vars2).sort();
                let key = vars.join(',');
                result[key] = (result[key] || 0) + coeff;
            }
        }

        let resArray = [];
        for (let key in result) {
            if (result[key] !== 0) {
                let term = [result[key]];
                if (key !== "") {
                    term = term.concat(key.split(','));
                }
                resArray.push(term);
            }
        }
        return [resArray, 0];
    }

    let tokens = tokenize(expression);
    let polynomial = evaluate(tokens)[0];

    polynomial.sort((a, b) => {
        let lenA = a.length - 1;
        let lenB = b.length - 1;
        if (lenA !== lenB) {
            return lenB - lenA;
        }
        for (let i = 1; i < a.length; i++) {
            if (a[i] !== b[i]) {
                return a[i].localeCompare(b[i]);
            }
        }
        return 0;
    });

    let result = [];
    for (let term of polynomial) {
        let coeff = term[0];
        let vars = term.slice(1);
        result.push(coeff + (vars.length > 0 ? "*" + vars.join("*") : ""));
    }

    return result;
};