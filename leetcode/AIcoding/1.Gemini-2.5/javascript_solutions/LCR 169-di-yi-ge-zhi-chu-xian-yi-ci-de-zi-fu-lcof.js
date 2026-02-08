var decodeString = function(s) {
    let numStack = [];
    let strStack = [];
    let currentNum = 0;
    let currentString = '';

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char >= '0' && char <= '9') {
            currentNum = currentNum * 10 + parseInt(char);
        } else if (char === '[') {
            numStack.push(currentNum);
            strStack.push(currentString);
            currentNum = 0;
            currentString = '';
        } else if (char === ']') {
            const prevNum = numStack.pop();
            const prevString = strStack.pop();
            currentString = prevString + currentString.repeat(prevNum);
        } else {
            currentString += char;
        }
    }

    return currentString;
};