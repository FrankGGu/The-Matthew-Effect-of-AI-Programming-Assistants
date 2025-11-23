var minLength = function(s) {
    let stack = [];
    for (let char of s) {
        if (stack.length > 0 && ((stack[stack.length - 1] === 'A' && char === 'B') || (stack[stack.length - 1] === 'B' && char === 'A'))) {
            stack.pop();
        } else if (stack.length > 0 && stack[stack.length - 1] === 'C' && char === 'D') {
            stack.pop();
        } else if (stack.length > 0 && stack[stack.length - 1] === 'D' && char === 'C') {
            stack.pop();
        } else {
            stack.push(char);
        }
    }
    return stack.length;
};