var simplifyPath = function(path) {
    const stack = [];
    const components = path.split('/');

    for (const component of components) {
        if (component === '' || component === '.') {
            // Ignore empty strings (due to multiple slashes) and current directory '.'
            continue;
        } else if (component === '..') {
            // Go up one directory, if possible
            if (stack.length > 0) {
                stack.pop();
            }
        } else {
            // It's a directory name, push it onto the stack
            stack.push(component);
        }
    }

    // Join the components in the stack with '/' and prepend a '/'
    // If the stack is empty, it means the path simplifies to the root directory "/"
    return '/' + stack.join('/');
};