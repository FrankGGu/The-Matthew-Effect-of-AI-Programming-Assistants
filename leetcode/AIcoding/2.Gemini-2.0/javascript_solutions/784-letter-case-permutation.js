var letterCasePermutation = function(s) {
    const result = [];
    const n = s.length;

    function backtrack(index, currentString) {
        if (index === n) {
            result.push(currentString);
            return;
        }

        const char = s[index];
        if (isNaN(parseInt(char))) {
            backtrack(index + 1, currentString + char.toLowerCase());
            backtrack(index + 1, currentString + char.toUpperCase());
        } else {
            backtrack(index + 1, currentString + char);
        }
    }

    backtrack(0, "");
    return result;
};