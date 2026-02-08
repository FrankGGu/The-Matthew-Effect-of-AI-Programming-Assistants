var calPoints = function(ops) {
    const stack = [];
    for (const op of ops) {
        if (op === "+") {
            stack.push(stack[stack.length - 1] + stack[stack.length - 2]);
        } else if (op === "D") {
            stack.push(stack[stack.length - 1] * 2);
        } else if (op === "C") {
            stack.pop();
        } else {
            stack.push(parseInt(op));
        }
    }
    let sum = 0;
    for (const score of stack) {
        sum += score;
    }
    return sum;
};