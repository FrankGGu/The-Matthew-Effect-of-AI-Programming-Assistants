var smallestNumber = function(pattern) {
    const n = pattern.length;
    const result = [];
    const stack = [];

    for (let i = 0; i <= n; i++) {
        stack.push(i + 1);
        if (i === n || pattern[i] === 'I') {
            while (stack.length) {
                result.push(stack.pop());
            }
        }
    }

    return result.join('');
};