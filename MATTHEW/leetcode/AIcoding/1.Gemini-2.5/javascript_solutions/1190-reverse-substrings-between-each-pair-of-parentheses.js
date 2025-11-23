var reverseParentheses = function(s) {
    let stack = [];
    let currentString = "";

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char === '(') {
            stack.push(currentString);
            currentString = "";
        } else if (char === ')') {
            currentString = currentString.split('').reverse().join('');
            currentString = stack.pop() + currentString;
        } else {
            currentString += char;
        }
    }

    return currentString;
};