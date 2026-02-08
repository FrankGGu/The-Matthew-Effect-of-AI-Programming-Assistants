var addOperators = function(num, target) {
    const result = [];

    const backtrack = (index, path, value, prev) => {
        if (index === num.length) {
            if (value === target) {
                result.push(path);
            }
            return;
        }

        for (let i = index; i < num.length; i++) {
            const currStr = num.substring(index, i + 1);
            const currNum = parseInt(currStr);

            if (i > index && num[index] === '0') break; // Skip leading zeroes

            if (index === 0) {
                backtrack(i + 1, currStr, currNum, currNum);
            } else {
                backtrack(i + 1, path + '+' + currStr, value + currNum, currNum);
                backtrack(i + 1, path + '-' + currStr, value - currNum, -currNum);
                backtrack(i + 1, path + '*' + currStr, value - prev + prev * currNum, prev * currNum);
            }
        }
    };

    backtrack(0, '', 0, 0);
    return result;
};