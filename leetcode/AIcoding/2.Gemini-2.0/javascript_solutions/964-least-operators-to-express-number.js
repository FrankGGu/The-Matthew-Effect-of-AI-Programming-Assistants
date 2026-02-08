var leastOpsExpressTarget = function(x, target) {
    const memo = new Map();

    function helper(target) {
        if (target === 0) return -1;
        if (target === 1) return 0;

        if (memo.has(target)) return memo.get(target);

        let p = 0;
        let power = 1;
        while (power <= target) {
            power *= x;
            p++;
        }

        let res;
        if (power === target) {
            res = p - 1;
        } else {
            let plus = helper(power - target) + p;
            let minus = helper(target - power / x) + p - 1;
            res = Math.min(plus, minus);
        }

        memo.set(target, res);
        return res;
    }

    return helper(target);
};