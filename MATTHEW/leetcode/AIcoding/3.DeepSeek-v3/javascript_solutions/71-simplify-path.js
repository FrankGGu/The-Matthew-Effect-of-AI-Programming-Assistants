var simplifyPath = function(path) {
    const stack = [];
    const parts = path.split('/');

    for (const part of parts) {
        if (part === '..') {
            if (stack.length > 0) {
                stack.pop();
            }
        } else if (part !== '' && part !== '.') {
            stack.push(part);
        }
    }

    return '/' + stack.join('/');
};