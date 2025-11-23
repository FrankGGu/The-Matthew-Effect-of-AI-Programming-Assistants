var scoreOfParentheses = function(s) {
    let balance = 0, score = 0;

    for (let char of s) {
        if (char === '(') {
            balance++;
        } else {
            balance--;
            if (s[s.indexOf(char) - 1] === '(') {
                score += 1 << balance;
            }
        }
    }

    return score;
};