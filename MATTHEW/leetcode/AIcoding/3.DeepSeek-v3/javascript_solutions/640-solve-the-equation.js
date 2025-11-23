var solveEquation = function(equation) {
    const parts = equation.split('=');
    const left = parts[0];
    const right = parts[1];

    function parse(expr) {
        let x = 0, num = 0;
        let sign = 1;
        let i = 0;
        while (i < expr.length) {
            if (expr[i] === '+' || expr[i] === '-') {
                sign = expr[i] === '+' ? 1 : -1;
                i++;
            }
            let val = 0;
            let isX = false;
            let j = i;
            while (j < expr.length && expr[j] !== '+' && expr[j] !== '-') {
                j++;
            }
            let term = expr.substring(i, j);
            if (term.includes('x')) {
                term = term.replace('x', '');
                if (term === '+' || term === '-') {
                    term += '1';
                }
                if (term === '') {
                    term = '1';
                }
                x += sign * parseInt(term, 10);
                isX = true;
            }
            if (!isX && term !== '') {
                num += sign * parseInt(term, 10);
            }
            i = j;
        }
        return { x, num };
    }

    const leftParsed = parse(left);
    const rightParsed = parse(right);

    const xTotal = leftParsed.x - rightParsed.x;
    const numTotal = rightParsed.num - leftParsed.num;

    if (xTotal === 0 && numTotal === 0) {
        return "Infinite solutions";
    } else if (xTotal === 0) {
        return "No solution";
    } else {
        return "x=" + (numTotal / xTotal);
    }
};