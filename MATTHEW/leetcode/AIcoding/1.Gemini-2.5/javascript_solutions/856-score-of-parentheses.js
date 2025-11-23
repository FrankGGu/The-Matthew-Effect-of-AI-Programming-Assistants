var scoreOfParentheses = function(s) {
    let stack = [0];

    for (let char of s) {
        if (char === '(') {
            stack.push(0);
        } else {
            let v = stack.pop();
            let currentLevelScore = stack.pop();
            let innerBlockScore = Math.max(2 * v, 1);
            stack.push(currentLevelScore + innerBlockScore);
        }
    }

    return stack[0];
};