var lengthLongestPath = function(input) {
    const paths = input.split('\n');
    const stack = [];
    let maxLength = 0;

    for (const path of paths) {
        const level = path.lastIndexOf('\t') + 1;
        const name = path.slice(level);

        while (stack.length > level) {
            stack.pop();
        }

        if (path.includes('.')) {
            maxLength = Math.max(maxLength, stack.join('/').length + name.length);
        } else {
            stack.push(name);
        }
    }

    return maxLength;
};