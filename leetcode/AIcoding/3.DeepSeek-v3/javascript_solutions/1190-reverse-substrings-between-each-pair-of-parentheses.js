var reverseParentheses = function(s) {
    const stack = [];
    let current = [];
    for (const char of s) {
        if (char === '(') {
            stack.push(current);
            current = [];
        } else if (char === ')') {
            current = stack.pop().concat(current.reverse());
        } else {
            current.push(char);
        }
    }
    return current.join('');
};