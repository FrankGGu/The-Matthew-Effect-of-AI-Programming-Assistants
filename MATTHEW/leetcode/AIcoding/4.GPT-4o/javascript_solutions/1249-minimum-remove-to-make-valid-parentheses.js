var minRemoveToMakeValid = function(s) {
    let stack = [];
    let toRemove = new Set();

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            stack.push(i);
        } else if (s[i] === ')') {
            if (stack.length === 0) {
                toRemove.add(i);
            } else {
                stack.pop();
            }
        }
    }

    while (stack.length > 0) {
        toRemove.add(stack.pop());
    }

    let result = '';
    for (let i = 0; i < s.length; i++) {
        if (!toRemove.has(i)) {
            result += s[i];
        }
    }

    return result;
};