var minRemoveToMakeValid = function(s) {
    const stack = [];
    const removeIndices = new Set();

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            stack.push(i);
        } else if (s[i] === ')') {
            if (stack.length > 0) {
                stack.pop();
            } else {
                removeIndices.add(i);
            }
        }
    }

    while (stack.length > 0) {
        removeIndices.add(stack.pop());
    }

    let result = '';
    for (let i = 0; i < s.length; i++) {
        if (!removeIndices.has(i)) {
            result += s[i];
        }
    }

    return result;
};