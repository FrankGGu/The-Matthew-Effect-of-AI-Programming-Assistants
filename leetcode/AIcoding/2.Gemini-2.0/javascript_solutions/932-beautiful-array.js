var beautifulArray = function(n) {
    let memo = new Map();

    function solve(n) {
        if (memo.has(n)) {
            return memo.get(n);
        }

        if (n === 1) {
            return [1];
        }

        let odds = solve(Math.floor((n + 1) / 2));
        let evens = solve(Math.floor(n / 2));

        let result = [];
        for (let num of odds) {
            result.push(2 * num - 1);
        }
        for (let num of evens) {
            result.push(2 * num);
        }

        memo.set(n, result);
        return result;
    }

    return solve(n);
};