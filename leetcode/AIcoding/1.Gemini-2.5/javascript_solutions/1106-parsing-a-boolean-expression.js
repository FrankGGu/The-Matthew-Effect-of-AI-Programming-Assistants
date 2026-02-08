var parseBoolExpr = function(expression) {
    let index = 0;

    function evaluate() {
        if (expression[index] === 't') {
            index++;
            return true;
        }
        if (expression[index] === 'f') {
            index++;
            return false;
        }

        const operator = expression[index]; // '&', '|', or '!'
        index++; // Move past operator
        index++; // Move past '('

        if (operator === '!') {
            const result = !evaluate();
            index++; // Move past ')'
            return result;
        }

        let currentResult;
        if (operator === '&') {
            currentResult = true;
            while (expression[index] !== ')') {
                currentResult = currentResult && evaluate();
                if (expression[index] === ',') {
                    index++; // Move past ','
                }
            }
        } else { // operator === '|'
            currentResult = false;
            while (expression[index] !== ')') {
                currentResult = currentResult || evaluate();
                if (expression[index] === ',') {
                    index++; // Move past ','
                }
            }
        }

        index++; // Move past ')'
        return currentResult;
    }

    return evaluate();
};