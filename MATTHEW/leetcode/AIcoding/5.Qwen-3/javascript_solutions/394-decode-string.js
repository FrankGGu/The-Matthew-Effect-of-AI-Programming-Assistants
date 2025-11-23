function decodeString(s) {
    const stack = [];
    let currentNum = 0;
    let currentStr = '';

    for (const char of s) {
        if (char >= '0' && char <= '9') {
            currentNum = currentNum * 10 + parseInt(char);
        } else if (char === '[') {
            stack.push({ str: currentStr, num: currentNum });
            currentStr = '';
            currentNum = 0;
        } else if (char === ']') {
            const { str, num } = stack.pop();
            currentStr = str + currentStr.repeat(num);
        } else {
            currentStr += char;
        }
    }

    return currentStr;
}