var minRemoveToMakeValid = function(s) {
    const stack = [];
    const toRemove = new Set();
    const n = s.length;

    for (let i = 0; i < n; i++) {
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

    let result = [];
    for (let i = 0; i < n; i++) {
        if (!toRemove.has(i)) {
            result.push(s[i]);
        }
    }

    return result.join('');
};