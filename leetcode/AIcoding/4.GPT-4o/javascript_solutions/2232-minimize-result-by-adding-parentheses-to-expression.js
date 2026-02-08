var minimizeResult = function(expression) {
    const [a, b] = expression.split('+');
    let minResult = Infinity;
    let bestExpression = '';

    for (let i = 0; i <= a.length; i++) {
        for (let j = 1; j <= b.length; j++) {
            const left = i === 0 ? 1 : parseInt(a.slice(0, i));
            const right = j === b.length ? 1 : parseInt(b.slice(j));
            const middle = parseInt(a.slice(i)) + parseInt(b.slice(0, j));
            const result = left * middle * right;

            if (result < minResult) {
                minResult = result;
                bestExpression = `${a.slice(0, i)}(${a.slice(i)}+${b.slice(0, j)})${b.slice(j)}`;
            }
        }
    }

    return bestExpression;
};