var numsSameConsecDiff = function(n, k) {
    let result = [];

    function dfs(num, len) {
        if (len === n) {
            result.push(num);
            return;
        }

        let lastDigit = num % 10;
        let nextDigits = [];
        if (lastDigit + k <= 9) {
            nextDigits.push(lastDigit + k);
        }
        if (k !== 0 && lastDigit - k >= 0) {
            nextDigits.push(lastDigit - k);
        }

        for (let nextDigit of nextDigits) {
            dfs(num * 10 + nextDigit, len + 1);
        }
    }

    for (let i = 1; i <= 9; i++) {
        dfs(i, 1);
    }

    return result;
};