var numsSameConsecDiff = function(n, k) {
    const result = [];

    function dfs(currentNum, digitsCount) {
        if (digitsCount === n) {
            result.push(currentNum);
            return;
        }

        const lastDigit = currentNum % 10;

        const nextDigit1 = lastDigit + k;
        if (nextDigit1 >= 0 && nextDigit1 <= 9) {
            dfs(currentNum * 10 + nextDigit1, digitsCount + 1);
        }

        if (k !== 0) {
            const nextDigit2 = lastDigit - k;
            if (nextDigit2 >= 0 && nextDigit2 <= 9) {
                dfs(currentNum * 10 + nextDigit2, digitsCount + 1);
            }
        }
    }

    if (n === 1) {
        for (let i = 0; i <= 9; i++) {
            result.push(i);
        }
    } else {
        for (let i = 1; i <= 9; i++) {
            dfs(i, 1);
        }
    }

    return result;
};