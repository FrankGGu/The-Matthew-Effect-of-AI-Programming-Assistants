var calPoints = function(operations) {
    let stack = [];
    for (let op of operations) {
        if (op === '+') {
            stack.push(stack[stack.length - 1] + stack[stack.length - 2]);
        } else if (op === 'D') {
            stack.push(2 * stack[stack.length - 1]);
        } else if (op === 'C') {
            stack.pop();
        } else {
            stack.push(parseInt(op));
        }
    }
    return stack.reduce((sum, num) => sum + num, 0);
};