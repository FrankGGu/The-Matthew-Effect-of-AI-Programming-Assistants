var backspaceCompare = function(s, t) {
    function processString(str) {
        const stack = [];
        for (const char of str) {
            if (char === '#') {
                if (stack.length > 0) {
                    stack.pop();
                }
            } else {
                stack.push(char);
            }
        }
        return stack.join('');
    }

    return processString(s) === processString(t);
};