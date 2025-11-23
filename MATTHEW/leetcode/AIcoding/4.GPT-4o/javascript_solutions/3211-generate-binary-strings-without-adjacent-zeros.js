function generateBinaryStrings(n) {
    const result = [];

    function backtrack(current, zeros) {
        if (current.length === n) {
            result.push(current);
            return;
        }
        backtrack(current + '1', 0);
        if (zeros < 1) {
            backtrack(current + '0', zeros + 1);
        }
    }

    backtrack('', 0);
    return result;
}