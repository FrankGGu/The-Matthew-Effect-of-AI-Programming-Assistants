var removeAdjacent = function(s) {
    const stack = [];
    for (let char of s) {
        if (stack.length > 0 && Math.abs(stack[stack.length - 1].charCodeAt(0) - char.charCodeAt(0)) <= 1) {
            stack.pop();
        } else {
            stack.push(char);
        }
    }
    return stack.join('');
};