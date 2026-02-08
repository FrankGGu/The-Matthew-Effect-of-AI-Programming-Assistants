var isValid = function(s) {
    const stack = [];
    for (const c of s) {
        if (c === 'c') {
            if (stack.length < 2 || stack.pop() !== 'b' || stack.pop() !== 'a') {
                return false;
            }
        } else {
            stack.push(c);
        }
    }
    return stack.length === 0;
};