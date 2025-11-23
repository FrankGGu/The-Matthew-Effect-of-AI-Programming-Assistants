var solveEquation = function(equation) {
    let [left, right] = equation.split('=');
    const parse = (expr) => {
        let coefficient = 0, constant = 0, sign = 1, num = '';
        for (let i = 0; i <= expr.length; i++) {
            const char = expr[i];
            if (char === '+' || char === '-' || i === expr.length) {
                if (num) {
                    const value = parseInt(num) * sign;
                    if (num.includes('x')) {
                        coefficient += value ? value : sign;
                    } else {
                        constant += value;
                    }
                    num = '';
                }
                sign = char === '-' ? -1 : 1;
            } else if (char === 'x') {
                num += 'x';
            } else {
                num += char;
            }
        }
        return [coefficient, constant];
    };

    const [leftCoeff, leftConst] = parse(left);
    const [rightCoeff, rightConst] = parse(right);

    const totalCoeff = leftCoeff - rightCoeff;
    const totalConst = rightConst - leftConst;

    if (totalCoeff === 0) {
        return totalConst === 0 ? "Infinite solutions" : "No solution";
    }

    return `x=${totalConst / totalCoeff}`;
};