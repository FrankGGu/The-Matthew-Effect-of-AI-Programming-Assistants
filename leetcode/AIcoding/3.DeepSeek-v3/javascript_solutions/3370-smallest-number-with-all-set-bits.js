var smallestNumber = function(pattern) {
    const n = pattern.length;
    const result = [];
    let stack = [];

    for (let i = 0; i <= n; i++) {
        stack.push(i + 1);
        if (i === n || pattern[i] === 'I') {
            while (stack.length > 0) {
                result.push(stack.pop());
            }
        }
    }

    return result.join('');
};