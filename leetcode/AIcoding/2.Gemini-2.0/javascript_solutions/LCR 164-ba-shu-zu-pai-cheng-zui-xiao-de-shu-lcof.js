var decodeString = function(s) {
    let stack = [];
    let num = 0;
    let str = '';

    for (let char of s) {
        if (char >= '0' && char <= '9') {
            num = num * 10 + (char - '0');
        } else if (char === '[') {
            stack.push(num);
            stack.push(str);
            num = 0;
            str = '';
        } else if (char === ']') {
            let prevStr = stack.pop();
            let repeatTimes = stack.pop();
            let tempStr = '';
            for (let i = 0; i < repeatTimes; i++) {
                tempStr += str;
            }
            str = prevStr + tempStr;
        } else {
            str += char;
        }
    }

    return str;
};