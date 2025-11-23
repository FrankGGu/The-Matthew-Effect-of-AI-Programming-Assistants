var scoreOfString = function(s) {
    let score = 0;
    let stack = [];

    for (let char of s) {
        if (char === '(') {
            stack.push(score);
            score = 0;
        } else {
            score = stack.pop() + Math.max(1, score * 2);
        }
    }

    return score;
};