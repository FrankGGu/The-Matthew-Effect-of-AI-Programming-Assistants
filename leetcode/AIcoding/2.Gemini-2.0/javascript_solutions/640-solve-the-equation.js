var solveEquation = function(equation) {
    let left = 0, right = 0, coeff = 0, num = 0, sign = 1;
    let i = 0;
    while (i < equation.length) {
        if (equation[i] === '+') {
            sign = 1;
            i++;
        } else if (equation[i] === '-') {
            sign = -1;
            i++;
        } else if (equation[i] === '=') {
            left = coeff;
            right = num;
            coeff = 0;
            num = 0;
            sign = 1;
            i++;
        } else {
            let j = i;
            while (j < equation.length && equation[j] >= '0' && equation[j] <= '9') {
                j++;
            }
            if (j < equation.length && equation[j] === 'x') {
                if (i === j) {
                    coeff += sign;
                } else {
                    coeff += sign * parseInt(equation.substring(i, j));
                }
                i = j + 1;
            } else {
                num += sign * parseInt(equation.substring(i, j));
                i = j;
            }
        }
    }

    coeff -= left;
    num = right - num;

    if (coeff === 0) {
        if (num === 0) {
            return "Infinite solutions";
        } else {
            return "No solution";
        }
    } else {
        return "x=" + (num / coeff);
    }
};