function removeOuterParentheses(S) {
    let result = '';
    let count = 0;

    for (let i = 0; i < S.length; i++) {
        if (S[i] === '(') {
            if (count > 0) result += S[i];
            count++;
        } else {
            if (count > 1) result += S[i];
            count--;
        }
    }

    return result;
}