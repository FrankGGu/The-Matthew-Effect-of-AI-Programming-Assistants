function isValid(s) {
    const stack = [];
    for (let char of s) {
        if (char === 'a') {
            stack.push(char);
        } else if (char === 'b') {
            if (stack.length > 0 && stack[stack.length - 1] === 'a') {
                stack.pop();
            } else {
                return false;
            }
        } else if (char === 'c') {
            if (stack.length > 1 && stack[stack.length - 1] === 'b' && stack[stack.length - 2] === 'a') {
                stack.pop();
                stack.pop();
            } else {
                return false;
            }
        }
    }
    return stack.length === 0;
}