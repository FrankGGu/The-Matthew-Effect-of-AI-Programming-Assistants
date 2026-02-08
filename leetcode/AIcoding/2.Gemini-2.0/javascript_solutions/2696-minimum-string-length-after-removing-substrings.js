var minLength = function(s) {
    const stack = [];
    for (let char of s) {
        if (stack.length > 0 && ((stack[stack.length - 1] === 'A' && char === 'B') || (stack[stack.length - 1] === 'C' && char === 'D'))) {
            stack.pop();
        } else {
            stack.push(char);
        }
    }
    return stack.length;
};