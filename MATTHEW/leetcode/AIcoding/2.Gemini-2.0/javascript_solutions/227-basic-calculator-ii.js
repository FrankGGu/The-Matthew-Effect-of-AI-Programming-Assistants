var calculate = function(s) {
    s = s.trim();
    let stack = [];
    let num = 0;
    let op = '+';

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (!isNaN(parseInt(char))) {
            num = num * 10 + parseInt(char);
        }

        if (isNaN(parseInt(char)) && char !== ' ' || i === s.length - 1) {
            if (op === '+') {
                stack.push(num);
            } else if (op === '-') {
                stack.push(-num);
            } else if (op === '*') {
                stack.push(stack.pop() * num);
            } else if (op === '/') {
                stack.push(parseInt(stack.pop() / num));
            }
            op = char;
            num = 0;
        }
    }

    let result = 0;
    while (stack.length > 0) {
        result += stack.pop();
    }

    return result;
};