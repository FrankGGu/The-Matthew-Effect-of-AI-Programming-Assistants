var removeAlmostEqualCharacters = function(s) {
    const stack = [];

    for (let i = 0; i < s.length; i++) {
        const currentChar = s[i];
        if (stack.length > 0) {
            const topChar = stack[stack.length - 1];
            const diff = Math.abs(currentChar.charCodeAt(0) - topChar.charCodeAt(0));
            if (diff <= 1) {
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