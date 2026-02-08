var calculate = function(s) {
    s = s.trim();
    let stack = [];
    let currentNumber = 0;
    let operation = '+';

    for (let i = 0; i < s.length; i++) {
        let char = s[i];

        if (char >= '0' && char <= '9') {
            currentNumber = currentNumber * 10 + parseInt(char);
        }

        if ((char < '0' || char > '9') && char !== ' ' || i === s.length - 1) {
            if (operation === '+') {
                stack.push(currentNumber);
            } else if (operation === '-') {
                stack.push(-currentNumber);
            } else if (operation === '*') {
                stack.push(stack.pop() * currentNumber);
            } else if (operation === '/') {
                stack.push(Math.trunc(stack.pop() / currentNumber));
            }

            if ((char < '0' || char > '9') && char !== ' ') {
                operation = char;
            }
            currentNumber = 0;
        }
    }

    let result = 0;
    while (stack.length > 0) {
        result += stack.pop();
    }

    return result;
};