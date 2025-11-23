var clearDigits = function(s) {
    const stack = [];
    for (const char of s) {
        if (/\d/.test(char)) {
            if (stack.length > 0) {
                stack.pop();
            }
        } else {
            stack.push(char);
        }
    }
    return stack.join('');
};