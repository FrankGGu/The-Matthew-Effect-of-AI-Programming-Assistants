function findMinimumOperations(s) {
    const n = s.length;
    if (n % 2 !== 0) return -1;
    const stack = [];
    for (let i = 0; i < n; i++) {
        if (stack.length > 0 && s[i] === ')' && stack[stack.length - 1] === '(') {
            stack.pop();
        } else {
            stack.push(s[i]);
        }
    }
    return stack.length / 2;
}