var scoreOfParentheses = function(s) {
    let score = 0;
    let balance = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            balance++;
        } else {
            balance--;
            if (s[i - 1] === '(') {
                score += Math.pow(2, balance);
            }
        }
    }
    return score;
};