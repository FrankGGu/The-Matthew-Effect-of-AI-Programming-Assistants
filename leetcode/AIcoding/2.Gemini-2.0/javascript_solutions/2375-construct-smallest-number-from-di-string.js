var smallestNumber = function(pattern) {
    let n = pattern.length;
    let result = "";
    let stack = [];
    for (let i = 0; i <= n; i++) {
        stack.push(i + 1);
        if (i === n || pattern[i] === 'I') {
            while (stack.length > 0) {
                result += stack.pop();
            }
        }
    }
    return result;
};