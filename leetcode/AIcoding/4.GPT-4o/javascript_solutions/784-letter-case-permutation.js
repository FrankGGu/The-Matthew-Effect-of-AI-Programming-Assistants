var letterCasePermutation = function(s) {
    const result = [];

    const backtrack = (index, path) => {
        if (index === s.length) {
            result.push(path);
            return;
        }

        backtrack(index + 1, path + s[index]);

        if (s[index].toLowerCase() !== s[index].toUpperCase()) {
            backtrack(index + 1, path + (s[index] === s[index].toLowerCase() ? s[index].toUpperCase() : s[index].toLowerCase()));
        }
    };

    backtrack(0, '');
    return result;
};