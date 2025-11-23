var letterCasePermutation = function(S) {
    const result = [];
    backtrack(S, 0, '', result);
    return result;
};

function backtrack(S, index, current, result) {
    if (index === S.length) {
        result.push(current);
        return;
    }

    const char = S[index];
    if (isLetter(char)) {
        backtrack(S, index + 1, current + char.toLowerCase(), result);
        backtrack(S, index + 1, current + char.toUpperCase(), result);
    } else {
        backtrack(S, index + 1, current + char, result);
    }
}

function isLetter(char) {
    return /[a-zA-Z]/.test(char);
}