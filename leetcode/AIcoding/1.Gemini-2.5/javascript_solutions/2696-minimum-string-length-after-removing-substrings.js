var minLength = function(s) {
    const stack = [];

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (stack.length > 0) {
            const top = stack[stack.length - 1];
            if ((top === 'A' && char === 'B') || (top === 'C' && char === 'D')) {
                stack.pop();
            } else {
                stack.push(char);
            }
        } else {
            stack.push(char);
        }
    }

    return stack.length;
};