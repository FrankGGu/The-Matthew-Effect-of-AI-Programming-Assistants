function scoreOfStudents(expression) {
    const memo = {};
    function evaluate(expr) {
        if (expr in memo) return memo[expr];
        if (isNaN(parseInt(expr))) {
            let res = 0;
            let i = 0;
            while (i < expr.length) {
                if (expr[i] === ' ') {
                    i++;
                    continue;
                }
                if (expr[i] === '(') {
                    let count = 1;
                    let j = i + 1;
                    while (count > 0 && j < expr.length) {
                        if (expr[j] === '(') count++;
                        else if (expr[j] === ')') count--;
                        j++;
                    }
                    const subExpr = expr.slice(i + 1, j - 1);
                    const val = evaluate(subExpr);
                    res += val;
                    i = j;
                } else {
                    let num = 0;
                    while (i < expr.length && !isNaN(parseInt(expr[i]))) {
                        num = num * 10 + parseInt(expr[i]);
                        i++;
                    }
                    res += num;
                }
            }
            memo[expr] = res;
            return res;
        } else {
            memo[expr] = parseInt(expr);
            return parseInt(expr);
        }
    }

    const correct = evaluate(expression);
    if (correct > 300) return 0;

    const set = new Set();
    function dfs(expr, i, curr) {
        if (i === expr.length) {
            if (curr <= 300) set.add(curr);
            return;
        }
        if (expr[i] === ' ') {
            dfs(expr, i + 1, curr);
            return;
        }
        if (expr[i] === '(') {
            let j = i + 1;
            let count = 1;
            while (j < expr.length && count > 0) {
                if (expr[j] === '(') count++;
                else if (expr[j] === ')') count--;
                j++;
            }
            const subExpr = expr.slice(i + 1, j - 1);
            const val = evaluate(subExpr);
            dfs(expr, j, curr + val);
        } else {
            let num = 0;
            while (i < expr.length && !isNaN(parseInt(expr[i]))) {
                num = num * 10 + parseInt(expr[i]);
                i++;
            }
            dfs(expr, i, curr + num);
        }
    }

    dfs(expression, 0, 0);
    let result = 0;
    for (const s of set) {
        if (s !== correct) result += 1;
    }
    return result;
}