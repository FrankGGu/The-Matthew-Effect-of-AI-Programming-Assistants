var isValid = function(s) {
    const stack = [];
    for (let char of s) {
        stack.push(char);
        while (stack.length >= 3 && stack.slice(-3).join('') === "abc") {
            stack.pop();
            stack.pop();
            stack.pop();
        }
    }
    return stack.length === 0;
};