var reverseParentheses = function(s) {
    const stack = [];
    let str = '';

    for (let char of s) {
        if (char === '(') {
            stack.push(str);
            str = '';
        } else if (char === ')') {
            str = stack.pop() + str.split('').reverse().join('');
        } else {
            str += char;
        }
    }

    return str;
};