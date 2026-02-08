var constructSmallestNumber = function(s) {
    const result = [];
    const stack = [];

    for (let i = 0; i <= s.length; i++) {
        stack.push(i + 1);
        if (i === s.length || s[i] === 'I') {
            while (stack.length > 0) {
                result.push(stack.pop());
            }
        }
    }

    return result.join('');
};