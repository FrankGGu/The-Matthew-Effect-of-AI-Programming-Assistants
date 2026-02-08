var removeOuterParentheses = function(s) {
    let result = [];
    let balance = 0;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === '(') {
            if (balance > 0) {
                result.push(char);
            }
            balance++;
        } else { // char === ')'
            balance--;
            if (balance > 0) {
                result.push(char);
            }
        }
    }

    return result.join('');
};