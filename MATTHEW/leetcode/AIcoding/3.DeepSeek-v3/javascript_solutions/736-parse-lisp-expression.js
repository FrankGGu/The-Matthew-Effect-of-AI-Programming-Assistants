var evaluate = function(expression) {
    const scope = [new Map()];
    let i = 0;

    const parseValue = () => {
        const token = parseToken();
        if (token[0] === '-' || (token[0] >= '0' && token[0] <= '9')) {
            return parseInt(token, 10);
        }
        for (let j = scope.length - 1; j >= 0; j--) {
            if (scope[j].has(token)) {
                return scope[j].get(token);
            }
        }
        return 0;
    };

    const parseToken = () => {
        while (expression[i] === ' ') i++;
        let token = '';
        while (i < expression.length && expression[i] !== ' ' && expression[i] !== ')') {
            token += expression[i++];
        }
        return token;
    };

    const evaluateExpr = () => {
        if (expression[i] !== '(') {
            return parseValue();
        }
        i++;
        const token = parseToken();
        let result;
        if (token === 'let') {
            i++;
            const vars = [];
            while (true) {
                if (expression[i] === '(') {
                    result = evaluateExpr();
                    break;
                }
                const varName = parseToken();
                if (expression[i] === ')') {
                    result = parseValue();
                    break;
                }
                const varValue = evaluateExpr();
                scope[scope.length - 1].set(varName, varValue);
                vars.push(varName);
            }
            for (const varName of vars) {
                scope[scope.length - 1].delete(varName);
            }
        } else if (token === 'add') {
            const a = evaluateExpr();
            const b = evaluateExpr();
            result = a + b;
        } else if (token === 'mult') {
            const a = evaluateExpr();
            const b = evaluateExpr();
            result = a * b;
        }
        i++;
        return result;
    };

    return evaluateExpr();
};