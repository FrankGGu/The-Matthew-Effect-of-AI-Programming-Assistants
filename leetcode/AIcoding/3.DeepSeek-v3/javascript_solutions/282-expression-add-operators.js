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
            if (i !== index && num[index] === '0') break;
            const currentStr = num.substring(index, i + 1);
            const current = parseInt(currentStr);

            if (index === 0) {
                backtrack(i + 1, currentStr, current, current);
            } else {
                backtrack(i + 1, path + '+' + currentStr, value + current, current);
                backtrack(i + 1, path + '-' + currentStr, value - current, -current);
                backtrack(i + 1, path + '*' + currentStr, value - prev + prev * current, prev * current);
            }
        }
    };

    backtrack(0, '', 0, 0);
    return result;
};