var validateStackSequences = function(pushed, popped) {
    const stack = [];
    let j = 0;

    for (let num of pushed) {
        stack.push(num);
        while (stack.length > 0 && stack[stack.length - 1] === popped[j]) {
            stack.pop();
            j++;
        }
    }

    return stack.length === 0;
};