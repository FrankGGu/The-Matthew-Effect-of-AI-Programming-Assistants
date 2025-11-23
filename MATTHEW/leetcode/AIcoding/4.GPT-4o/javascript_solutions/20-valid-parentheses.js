var isValid = function(s) {
    const stack = [];
    const mapping = { '(': ')', '{': '}', '[': ']' };

    for (let char of s) {
        if (mapping[char]) {
            stack.push(mapping[char]);
        } else {
            if (stack.pop() !== char) {
                return false;
            }
        }
    }
    return stack.length === 0;
};