var backspaceCompare = function(s, t) {
    const process = (str) => {
        const stack = [];
        for (const char of str) {
            if (char === '#') {
                stack.pop();
            } else {
                stack.push(char);
            }
        }
        return stack.join('');
    };
    return process(s) === process(t);
};