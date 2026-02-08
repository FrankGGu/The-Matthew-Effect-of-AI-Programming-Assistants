var addOperators = function(num, target) {
    const res = [];

    function backtrack(index, currentExpression, currentValue, previousOperand) {
        if (index === num.length) {
            if (currentValue === target) {
                res.push(currentExpression);
            }
            return;
        }

        for (let i = index; i < num.length; i++) {
            if (i > index && num[index] === '0') break; 

            const currentOperand = parseInt(num.substring(index, i + 1));

            if (index === 0) {
                backtrack(i + 1, currentOperand.toString(), currentOperand, currentOperand);
            } else {
                backtrack(i + 1, currentExpression + "+" + currentOperand, currentValue + currentOperand, currentOperand);
                backtrack(i + 1, currentExpression + "-" + currentOperand, currentValue - currentOperand, -currentOperand);
                backtrack(i + 1, currentExpression + "*" + currentOperand, currentValue - previousOperand + previousOperand * currentOperand, previousOperand * currentOperand);
            }
        }
    }

    backtrack(0, "", 0, 0);
    return res;
};