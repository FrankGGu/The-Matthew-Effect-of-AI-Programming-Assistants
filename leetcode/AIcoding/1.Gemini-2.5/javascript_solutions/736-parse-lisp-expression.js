var evaluate = function(expression) {
    class Scope {
        constructor(parent = null) {
            this.vars = new Map();
            this.parent = parent;
        }

        set(name, value) {
            this.vars.set(name, value);
        }

        get(name) {
            if (this.vars.has(name)) {
                return this.vars.get(name);
            }
            if (this.parent) {
                return this.parent.get(name);
            }
            return null;
        }
    }

    function parseTokens(str) {
        const tokens = [];
        let balance = 0;
        let start = 0;
        for (let i = 0; i < str.length; i++) {
            const char = str[i];
            if (char === '(') {
                balance++;
            } else if (char === ')') {
                balance--;
            } else if (char === ' ' && balance === 0) {
                tokens.push(str.substring(start, i));
                start = i + 1;
            }
        }
        tokens.push(str.substring(start, str.length));
        return tokens;
    }

    function evaluateExpr(expr, scope) {
        if (expr.length > 0 && (expr[0] === '-' || (expr[0] >= '0' && expr[0] <= '9'))) {
            return parseInt(expr);
        }

        if (expr[0] !== '(') {
            return scope.get(expr);
        }

        const innerExpr = expr.substring(1, expr.length - 1);
        const tokens = parseTokens(innerExpr);
        const command = tokens[0];

        if (command === 'let') {
            const newScope = new Scope(scope);
            for (let i = 1; i < tokens.length - 1; i += 2) {
                const varName = tokens[i];
                const varValueExpr = tokens[i + 1];
                const value = evaluateExpr(varValueExpr, newScope);
                newScope.set(varName, value);
            }
            return evaluateExpr(tokens[tokens.length - 1], newScope);

        } else if (command === 'add') {
            const val1 = evaluateExpr(tokens[1], scope);
            const val2 = evaluateExpr(tokens[2], scope);
            return val1 + val2;

        } else if (command === 'mult') {
            const val1 = evaluateExpr(tokens[1], scope);
            const val2 = evaluateExpr(tokens[2], scope);
            return val1 * val2;
        }
        return 0;
    }

    return evaluateExpr(expression, new Scope());
};