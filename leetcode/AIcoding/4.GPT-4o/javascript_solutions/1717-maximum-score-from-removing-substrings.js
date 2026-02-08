var maximumScore = function(s) {
    let totalScore = 0;
    let stack = [];

    for (let i = 0; i < s.length; i++) {
        stack.push(s[i]);
        while (stack.length > 1) {
            let last = stack[stack.length - 1];
            let secondLast = stack[stack.length - 2];
            if ((last === 'A' && secondLast === 'B') || (last === 'B' && secondLast === 'A')) {
                totalScore += 1;
                stack.pop();
                stack.pop();
            } else if ((last === 'B' && secondLast === 'C') || (last === 'C' && secondLast === 'B')) {
                totalScore += 2;
                stack.pop();
                stack.pop();
            } else if ((last === 'C' && secondLast === 'A') || (last === 'A' && secondLast === 'C')) {
                totalScore += 3;
                stack.pop();
                stack.pop();
            } else {
                break;
            }
        }
    }

    return totalScore;
};