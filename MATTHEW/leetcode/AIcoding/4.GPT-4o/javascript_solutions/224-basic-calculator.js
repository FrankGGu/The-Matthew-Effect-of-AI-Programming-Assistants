function calculate(s) {
    const stack = [];
    let num = 0;
    let sign = 1; // 1 means positive, -1 means negative
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const char = s[i];

        if (char >= '0' && char <= '9') {
            num = num * 10 + (char - '0');
        } else if (char === '+') {
            stack.push(sign * num);
            num = 0;
            sign = 1;
        } else if (char === '-') {
            stack.push(sign * num);
            num = 0;
            sign = -1;
        } else if (char === '(') {
            stack.push(sign);
            stack.push(0);
            sign = 1;
        } else if (char === ')') {
            stack.push(sign * num);
            num = 0;
            let sum = 0;
            while (stack.length > 0 && typeof stack[stack.length - 1] === 'number') {
                sum += stack.pop();
            }
            sum *= stack.pop(); // pop the sign
            stack.push(sum);
        }
    }

    stack.push(sign * num);

    return stack.reduce((a, b) => a + b, 0);
}