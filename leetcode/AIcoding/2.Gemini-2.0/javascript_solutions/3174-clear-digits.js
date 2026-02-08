var clearTheDigits = function(n) {
    const s = String(n);
    let stack = [];
    for (let i = 0; i < s.length; i++) {
        while (stack.length > 0 && stack[stack.length - 1] < s[i] && s.length - i + stack.length > s.length) {
            stack.pop();
        }
        if (stack.length < s.length) {
            stack.push(s[i]);
        }
    }
    return parseInt(stack.join(''));
};