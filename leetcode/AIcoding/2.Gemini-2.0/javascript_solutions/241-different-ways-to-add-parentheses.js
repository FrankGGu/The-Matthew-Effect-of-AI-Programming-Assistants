var diffWaysToCompute = function(expression) {
    const memo = new Map();

    function helper(s) {
        if (memo.has(s)) {
            return memo.get(s);
        }

        const result = [];
        for (let i = 0; i < s.length; i++) {
            const char = s[i];
            if (char === '+' || char === '-' || char === '*') {
                const left = helper(s.substring(0, i));
                const right = helper(s.substring(i + 1));

                for (const l of left) {
                    for (const r of right) {
                        let res;
                        if (char === '+') {
                            res = l + r;
                        } else if (char === '-') {
                            res = l - r;
                        } else {
                            res = l * r;
                        }
                        result.push(res);
                    }
                }
            }
        }

        if (result.length === 0) {
            result.push(parseInt(s));
        }

        memo.set(s, result);
        return result;
    }

    return helper(expression);
};