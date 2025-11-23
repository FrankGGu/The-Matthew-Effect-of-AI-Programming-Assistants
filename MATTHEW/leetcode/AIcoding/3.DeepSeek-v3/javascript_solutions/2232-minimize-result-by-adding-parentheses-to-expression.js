var minimizeResult = function(expression) {
    const plusIndex = expression.indexOf('+');
    const left = expression.substring(0, plusIndex);
    const right = expression.substring(plusIndex + 1);
    let minVal = Infinity;
    let result = '';

    for (let i = 0; i < left.length; i++) {
        for (let j = 1; j <= right.length; j++) {
            const a = i === 0 ? 1 : parseInt(left.substring(0, i));
            const b = parseInt(left.substring(i)) + parseInt(right.substring(0, j));
            const c = j === right.length ? 1 : parseInt(right.substring(j));
            const current = a * b * c;

            if (current < minVal) {
                minVal = current;
                result = `${left.substring(0, i)}(${left.substring(i)}+${right.substring(0, j)})${right.substring(j)}`;
            }
        }
    }

    return result;
};