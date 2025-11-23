var generateBinaryStrings = function(n) {
    let result = [];
    function backtrack(current, lastChar) {
        if (current.length === n) {
            result.push(current);
            return;
        }
        backtrack(current + '1', '1');
        if (lastChar !== '0') {
            backtrack(current + '0', '0');
        }
    }
    backtrack('', '');
    return result;
};