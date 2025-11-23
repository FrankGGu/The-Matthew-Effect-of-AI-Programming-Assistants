function canBeEmpty(s) {
    let stack = [];
    for (let char of s) {
        if (char === '#') {
            if (stack.length > 0) {
                stack.pop();
            }
        } else {
            stack.push(char);
        }
    }
    return stack.length === 0;
}