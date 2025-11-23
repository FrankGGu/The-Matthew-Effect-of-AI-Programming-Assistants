var scoreOfParentheses = function(S) {
    let stack = [0];
    for (let c of S) {
        if (c === '(') {
            stack.push(0);
        } else {
            let top = stack.pop();
            let value = stack.pop();
            stack.push(value + Math.max(2 * top, 1));
        }
    }
    return stack.pop();
};