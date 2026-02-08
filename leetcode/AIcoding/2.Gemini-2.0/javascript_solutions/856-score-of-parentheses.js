var scoreOfParentheses = function(s) {
    let stack = [0];
    for (let char of s) {
        if (char === '(') {
            stack.push(0);
        } else {
            let val = stack.pop();
            stack[stack.length - 1] += Math.max(2 * val, 1);
        }
    }
    return stack[0];
};