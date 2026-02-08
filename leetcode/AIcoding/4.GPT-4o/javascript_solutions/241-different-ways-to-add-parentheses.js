var diffWaysToCompute = function(expression) {
    const ways = [];
    for (let i = 0; i < expression.length; i++) {
        const char = expression[i];
        if (char === '+' || char === '-' || char === '*') {
            const left = diffWaysToCompute(expression.substring(0, i));
            const right = diffWaysToCompute(expression.substring(i + 1));
            for (const l of left) {
                for (const r of right) {
                    if (char === '+') {
                        ways.push(l + r);
                    } else if (char === '-') {
                        ways.push(l - r);
                    } else if (char === '*') {
                        ways.push(l * r);
                    }
                }
            }
        }
    }
    if (ways.length === 0) {
        ways.push(Number(expression));
    }
    return ways;
};