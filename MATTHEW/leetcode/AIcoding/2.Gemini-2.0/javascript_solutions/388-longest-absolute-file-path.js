var lengthLongestPath = function(input) {
    const stack = [0];
    let maxLength = 0;
    const files = input.split('\n');

    for (const file of files) {
        const level = file.lastIndexOf('\t') + 1;
        const name = file.substring(level);

        while (level + 1 < stack.length) {
            stack.pop();
        }

        const length = stack[stack.length - 1] + name.length;

        if (name.includes('.')) {
            maxLength = Math.max(maxLength, length);
        } else {
            stack.push(length + 1);
        }
    }

    return maxLength;
};