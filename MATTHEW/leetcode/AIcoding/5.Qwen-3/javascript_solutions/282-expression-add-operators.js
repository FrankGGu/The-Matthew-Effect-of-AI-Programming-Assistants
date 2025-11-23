function addOperators(num, target) {
    const result = [];

    function backtrack(start, path, currentSum, prevTerm) {
        if (start === num.length) {
            if (currentSum === target) {
                result.push(path);
            }
            return;
        }

        for (let i = start + 1; i <= num.length; i++) {
            if (i > start + 1 && num[start] === '0') break;

            const currentNum = parseInt(num.substring(start, i), 10);

            if (start === 0) {
                backtrack(i, num.substring(start, i), currentNum, currentNum);
            } else {
                backtrack(i, path + '+' + num.substring(start, i), currentSum + currentNum, currentNum);
                backtrack(i, path + '-' + num.substring(start, i), currentSum - currentNum, -currentNum);
                backtrack(i, path + '*' + num.substring(start, i), currentSum - prevTerm + prevTerm * currentNum, prevTerm * currentNum);
            }
        }
    }

    backtrack(0, '', 0, 0);
    return result;
}