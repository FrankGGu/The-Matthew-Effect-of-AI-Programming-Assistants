function removeOuterParentheses(s) {
    let result = '';
    let balance = 0;
    for (let char of s) {
        if (char === '(') {
            balance++;
        } else {
            balance--;
        }
        if (balance !== 0) {
            result += char;
        }
    }
    return result;
}