var clumsy = function(N) {
    let stack = [N];
    let opIndex = 0; // 0: *, 1: /, 2: +, 3: -

    for (let i = N - 1; i >= 1; i--) {
        if (opIndex % 4 === 0) { // Multiply
            let prev = stack.pop();
            stack.push(prev * i);
        } else if (opIndex % 4 === 1) { // Divide
            let prev = stack.pop();
            stack.push(Math.trunc(prev / i)); // Integer division towards zero
        } else if (opIndex % 4 === 2) { // Add
            stack.push(i);
        } else { // opIndex % 4 === 3, Subtract
            stack.push(-i);
        }
        opIndex++;
    }

    let result = 0;
    while (stack.length > 0) {
        result += stack.pop();
    }

    return result;
};