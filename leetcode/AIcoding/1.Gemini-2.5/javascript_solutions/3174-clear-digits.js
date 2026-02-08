var clearDigits = function(s) {
    const stack = [];

    for (const char of s) {
        if (char >= '0' && char <= '9') {
            if (stack.length > 0) {
                stack.pop();
            }
        } else {
            stack.push(char);
        }
    }

    return stack.join('');
};