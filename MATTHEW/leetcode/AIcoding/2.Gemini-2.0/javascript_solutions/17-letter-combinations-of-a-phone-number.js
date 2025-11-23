var letterCombinations = function(digits) {
    if (!digits) return [];
    const map = {
        '2': 'abc',
        '3': 'def',
        '4': 'ghi',
        '5': 'jkl',
        '6': 'mno',
        '7': 'pqrs',
        '8': 'tuv',
        '9': 'wxyz'
    };
    const result = [];
    const backtrack = (index, combination) => {
        if (index === digits.length) {
            result.push(combination);
            return;
        }
        const letters = map[digits[index]];
        for (let i = 0; i < letters.length; i++) {
            backtrack(index + 1, combination + letters[i]);
        }
    };
    backtrack(0, '');
    return result;
};