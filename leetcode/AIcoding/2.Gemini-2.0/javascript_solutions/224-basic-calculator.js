var calculate = function(s) {
    let stack = [];
    let num = 0;
    let sign = 1;
    let res = 0;

    for (let i = 0; i < s.length; i++) {
        let char = s[i];

        if (char >= '0' && char <= '9') {
            num = num * 10 + (char - '0');
        } else if (char === '+') {
            res += sign * num;
            num = 0;
            sign = 1;
        } else if (char === '-') {
            res += sign * num;
            num = 0;
            sign = -1;
        } else if (char === '(') {
            stack.push(res);
            stack.push(sign);
            res = 0;
            sign = 1;
        } else if (char === ')') {
            res += sign * num;
            num = 0;
            res *= stack.pop();
            res += stack.pop();
        }
    }

    if (num !== 0) {
        res += sign * num;
    }

    return res;
};