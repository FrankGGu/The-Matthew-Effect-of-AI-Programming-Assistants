var letterCombinations = function(digits) {
    if (!digits) return [];
    const phoneMap = {
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

    const backtrack = (combination, nextDigits) => {
        if (nextDigits.length === 0) {
            result.push(combination);
        } else {
            const digit = nextDigits.charAt(0);
            const letters = phoneMap[digit];
            for (let i = 0; i < letters.length; i++) {
                backtrack(combination + letters.charAt(i), nextDigits.slice(1));
            }
        }
    };

    backtrack('', digits);
    return result;
};