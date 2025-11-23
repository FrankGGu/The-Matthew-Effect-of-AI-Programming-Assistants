var diffWaysToCompute = function(expression) {
    const memo = new Map();

    function compute(left, right, op) {
        const res = [];
        for (const l of left) {
            for (const r of right) {
                if (op === '+') {
                    res.push(l + r);
                } else if (op === '-') {
                    res.push(l - r);
                } else if (op === '*') {
                    res.push(l * r);
                }
            }
        }
        return res;
    }

    function dfs(s) {
        if (memo.has(s)) {
            return memo.get(s);
        }
        const res = [];
        for (let i = 0; i < s.length; i++) {
            const c = s[i];
            if (c === '+' || c === '-' || c === '*') {
                const left = dfs(s.substring(0, i));
                const right = dfs(s.substring(i + 1));
                const combined = compute(left, right, c);
                res.push(...combined);
            }
        }
        if (res.length === 0) {
            res.push(parseInt(s));
        }
        memo.set(s, res);
        return res;
    }

    return dfs(expression);
};