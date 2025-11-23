function solveEquation(equation) {
    function parse(expr) {
        let i = 0;
        const n = expr.length;
        let sign = 1;
        let num = 0;
        let x = 0;
        while (i < n) {
            if (expr[i] === '+') {
                sign = 1;
                i++;
            } else if (expr[i] === '-') {
                sign = -1;
                i++;
            } else if (expr[i] === 'x') {
                x += sign;
                i++;
            } else if (expr[i] === '=') {
                i++;
                break;
            } else {
                num = 0;
                while (i < n && expr[i] >= '0' && expr[i] <= '9') {
                    num = num * 10 + parseInt(expr[i]);
                    i++;
                }
                if (i < n && expr[i] === 'x') {
                    x += sign * num;
                    i++;
                } else {
                    num *= sign;
                    i++;
                }
            }
        }
        return [x, num];
    }

    const [leftX, leftNum] = parse(equation);
    const [rightX, rightNum] = parse(equation.substring(equation.indexOf('=') + 1));

    const totalX = leftX - rightX;
    const totalNum = rightNum - leftNum;

    if (totalX === 0) {
        return totalNum === 0 ? "Infinite solutions" : "No solution";
    }

    return `x=${totalNum / totalX}`;
}