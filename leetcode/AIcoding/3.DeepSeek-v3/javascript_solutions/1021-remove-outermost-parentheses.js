var removeOuterParentheses = function(S) {
    let result = '';
    let balance = 0;
    let start = 0;

    for (let i = 0; i < S.length; i++) {
        if (S[i] === '(') {
            balance++;
        } else {
            balance--;
        }

        if (balance === 0) {
            result += S.substring(start + 1, i);
            start = i + 1;
        }
    }

    return result;
};