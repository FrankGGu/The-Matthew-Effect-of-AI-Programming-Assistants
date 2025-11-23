var numberOfBeautifulIntegers = function(low, high, k) {
    const memo = new Array(11).fill(null).map(() => new Array(101).fill(null).map(() => new Array(2).fill(null)));

    function countBeautifulIntegers(numStr, index, remainder, isTight, k) {
        if (index === numStr.length) {
            return remainder === 0 ? 1 : 0;
        }

        if (memo[index][remainder][isTight] !== null) {
            return memo[index][remainder][isTight];
        }

        let limit = isTight ? Number(numStr[index]) : 9;
        let count = 0;

        for (let digit = 0; digit <= limit; digit++) {
            count += countBeautifulIntegers(
                numStr,
                index + 1,
                (remainder * 10 + digit) % k,
                isTight && digit === limit,
                k
            );
        }

        memo[index][remainder][isTight] = count;
        return count;
    }

    function solve(num, k) {
        const numStr = String(num);
        memo.forEach(row => row.forEach(innerRow => innerRow.fill(null)));
        return countBeautifulIntegers(numStr, 0, 0, true, k);
    }

    return solve(high, k) - solve(low - 1, k);
};