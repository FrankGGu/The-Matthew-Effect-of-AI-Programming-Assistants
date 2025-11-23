var smallestString = function(s) {
    const stack = [];
    for (const char of s) {
        while (stack.length > 0 && stack[stack.length - 1] > char) {
            stack.pop();
        }
        stack.push(char);
    }
    return stack.join('');
};