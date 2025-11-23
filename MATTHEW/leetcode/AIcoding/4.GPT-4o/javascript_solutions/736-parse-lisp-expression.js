var evaluate = function(expression) {
    const stack = [];
    const getValue = (expr) => {
        if (!isNaN(expr)) return Number(expr);
        if (expr in map) return map[expr];
        if (expr.startsWith('(')) {
            const innerExpr = expr.slice(1, -1);
            let i = 0, depth = 0, cmd = '';
            while (i < innerExpr.length) {
                if (innerExpr[i] === ' ' && depth === 0) {
                    if (cmd) break;
                    i++;
                    continue;
                }
                if (innerExpr[i] === '(') depth++;
                if (innerExpr[i] === ')') depth--;
                cmd += innerExpr[i];
                i++;
            }
            const args = innerExpr.slice(cmd.length).trim().split(' ').filter(s => s);
            return execute(cmd, args);
        }
        return 0;
    };

    const execute = (cmd, args) => {
        if (cmd === 'add') return getValue(args[0]) + getValue(args[1]);
        if (cmd === 'mult') return getValue(args[0]) * getValue(args[1]);
        if (cmd === 'let') {
            const localMap = {...map};
            for (let i = 0; i < args.length - 1; i += 2) {
                localMap[args[i]] = getValue(args[i + 1]);
            }
            return getValue(args[args.length - 1]);
        }
    };

    const map = {};
    return getValue(expression);
};