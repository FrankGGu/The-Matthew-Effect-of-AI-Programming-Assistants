var validateStackSequences = function(pushed, popped) {
    let stack = [];
    let i = 0;
    let j = 0;

    while (i < pushed.length) {
        stack.push(pushed[i]);

        while (stack.length > 0 && stack[stack.length - 1] === popped[j]) {
            stack.pop();
            j++;
        }

        i++;
    }

    return stack.length === 0;
};