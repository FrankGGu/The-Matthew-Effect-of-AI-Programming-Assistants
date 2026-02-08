var calculate = function(s) {
    let result = 0;
    let sign = 1;
    let stack = [];

    for (let i = 0; i < s.length; i++) {
        let char = s[i];

        if (char >= '0' && char <= '9') {
            let num = 0;
            while (i < s.length && s[i] >= '0' && s[i] <= '9') {
                num = num * 10 + parseInt(s[i]);
                i++;
            }
            i--;
            result += num * sign;
        } else if (char === '+') {
            sign = 1;
        } else if (char === '-') {
            sign = -1;
        } else if (char === '(') {
            stack.push(result);
            stack.push(sign);
            result = 0;
            sign = 1;
        } else if (char === ')') {
            let prevSign = stack.pop();
            let prevResult = stack.pop();
            result = prevResult + result * prevSign;
        }
    }

    return result;
};