var clumsy = function(N) {
    let stack = [N--];
    let index = 0;
    while (N > 0) {
        if (index % 4 === 0) {
            stack.push(stack.pop() * N);
        } else if (index % 4 === 1) {
            let val = stack.pop();
            stack.push(val > 0 ? Math.floor(val / N) : Math.ceil(val / N));
        } else if (index % 4 === 2) {
            stack.push(N);
        } else {
            stack.push(-N);
        }
        index++;
        N--;
    }
    return stack.reduce((a, b) => a + b, 0);
};