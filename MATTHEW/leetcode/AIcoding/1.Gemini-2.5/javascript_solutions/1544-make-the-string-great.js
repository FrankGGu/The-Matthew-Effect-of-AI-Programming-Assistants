var makeGood = function(s) {
    const stack = [];

    for (let i = 0; i < s.length; i++) {
        const currentChar = s[i];
        if (stack.length > 0) {
            const lastChar = stack[stack.length - 1];
            if (Math.abs(currentChar.charCodeAt(0) - lastChar.charCodeAt(0)) === 32) {
                stack.pop();
            } else {
                stack.push(currentChar);
            }
        } else {
            stack.push(currentChar);
        }
    }

    return stack.join('');
};