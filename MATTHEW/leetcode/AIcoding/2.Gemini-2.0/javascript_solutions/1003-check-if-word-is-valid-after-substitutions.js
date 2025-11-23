var isValid = function(s) {
    const stack = [];
    for (let i = 0; i < s.length; i++) {
        stack.push(s[i]);
        while (stack.length >= 3 && stack[stack.length - 3] === 'a' && stack[stack.length - 2] === 'b' && stack[stack.length - 1] === 'c') {
            stack.pop();
            stack.pop();
            stack.pop();
        }
    }
    return stack.length === 0;
};