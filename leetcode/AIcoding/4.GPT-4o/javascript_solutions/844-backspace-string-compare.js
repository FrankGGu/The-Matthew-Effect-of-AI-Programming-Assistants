var backspaceCompare = function(s, t) {
    const buildString = (str) => {
        const stack = [];
        for (let char of str) {
            if (char !== '#') {
                stack.push(char);
            } else if (stack.length > 0) {
                stack.pop();
            }
        }
        return stack.join('');
    };

    return buildString(s) === buildString(t);
};