function calculate(s) {
    let stack = [];
    let num = 0;
    let sign = '+';
    for (let i = 0; i < s.length; i++) {
        let c = s[i];
        if (c >= '0' && c <= '9') {
            num = num * 10 + parseInt(c);
        }
        if ((c < '0' && c !== ' ') || i === s.length - 1) {
            if (sign === '+') {
                stack.push(num);
            } else if (sign === '-') {
                stack.push(-num);
            } else if (sign === '*') {
                stack.push(stack.pop() * num);
            } else if (sign === '/') {
                stack.push(Math.trunc(stack.pop() / num));
            }
            sign = c;
            num = 0;
        }
    }
    return stack.reduce((a, b) => a + b, 0);
}