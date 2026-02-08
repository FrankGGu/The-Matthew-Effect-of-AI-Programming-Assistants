var lengthLongestPath = function(input) {
    const stack = [];
    let maxLen = 0;
    const parts = input.split('\n');

    for (const part of parts) {
        const level = part.lastIndexOf('\t') + 1;
        const name = part.substring(level);

        while (stack.length > level) {
            stack.pop();
        }

        const currentLength = (stack.length > 0 ? stack[stack.length - 1] : 0) + name.length;
        stack.push(currentLength + 1); // +1 for the '/'

        if (name.includes('.')) {
            maxLen = Math.max(maxLen, currentLength);
        }
    }

    return maxLen;
};