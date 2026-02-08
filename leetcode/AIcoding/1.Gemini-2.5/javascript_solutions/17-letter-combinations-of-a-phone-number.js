var letterCombinations = function(digits) {
    const result = [];
    if (digits.length === 0) {
        return result;
    }

    const mapping = {
        '2': 'abc',
        '3': 'def',
        '4': 'ghi',
        '5': 'jkl',
        '6': 'mno',
        '7': 'pqrs',
        '8': 'tuv',
        '9': 'wxyz'
    };

    function backtrack(index, currentCombination) {
        if (index === digits.length) {
            result.push(currentCombination);
            return;
        }

        const digit = digits[index];
        const letters = mapping[digit];

        for (let i = 0; i < letters.length; i++) {
            backtrack(index + 1, currentCombination + letters[i]);
        }
    }

    backtrack(0, "");
    return result;
};