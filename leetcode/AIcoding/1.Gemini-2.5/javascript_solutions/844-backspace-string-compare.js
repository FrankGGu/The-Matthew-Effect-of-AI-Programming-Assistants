var backspaceCompare = function(s, t) {
    const buildString = (str) => {
        const stack = [];
        for (let i = 0; i < str.length; i++) {
            if (str[i] === '#') {
                if (stack.length > 0) {
                    stack.pop();
                }
            } else {
                stack.push(str[i]);
            }
        }
        return stack.join('');
    };

    return buildString(s) === buildString(t);
};