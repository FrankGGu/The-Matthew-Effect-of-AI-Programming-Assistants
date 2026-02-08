var calculate = function(s) {
    let stack = [];
    let num = 0;
    let sign = 1;
    let result = 0;

    for (let i = 0; i < s.length; i++) {
        let c = s[i];
        if (c >= '0' && c <= '9') {
            num = num * 10 + parseInt(c);
        } else if (c === '+') {
            result += sign * num;
            num = 0;
            sign = 1;
        } else if (c === '-') {
            result += sign * num;
            num = 0;
            sign = -1;
        } else if (c === '(') {
            stack.push(result);
            stack.push(sign);
            result = 0;
            sign = 1;
        } else if (c === ')') {
            result += sign * num;
            num = 0;
            result *= stack.pop();
            result += stack.pop();
        }
    }

    if (num !== 0) {
        result += sign * num;
    }

    return result;
};