var diffWaysToCompute = function(expression) {
    const memo = new Map();

    function compute(subExpression) {
        if (memo.has(subExpression)) {
            return memo.get(subExpression);
        }

        const results = [];
        let isNumber = true;

        for (let i = 0; i < subExpression.length; i++) {
            const char = subExpression[i];
            if (char === '+' || char === '-' || char === '*') {
                isNumber = false;
                const leftResults = compute(subExpression.substring(0, i));
                const rightResults = compute(subExpression.substring(i + 1));

                for (const leftVal of leftResults) {
                    for (const rightVal of rightResults) {
                        if (char === '+') {
                            results.push(leftVal + rightVal);
                        } else if (char === '-') {
                            results.push(leftVal - rightVal);
                        } else { // char === '*'
                            results.push(leftVal * rightVal);
                        }
                    }
                }
            }
        }

        if (isNumber) {
            results.push(parseInt(subExpression));
        }

        memo.set(subExpression, results);
        return results;
    }

    return compute(expression);
};