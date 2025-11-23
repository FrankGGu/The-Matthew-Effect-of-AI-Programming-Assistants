function validateStackSequences(pushed, popped) {
    const stack = [];
    let i = 0;
    for (const num of pushed) {
        stack.push(num);
        while (stack.length > 0 && stack[stack.length - 1] === popped[i]) {
            stack.pop();
            i++;
        }
    }
    return i === popped.length;
}