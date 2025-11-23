function diffWaysToCompute(input) {
    const memo = {};

    function helper(s) {
        if (memo[s] !== undefined) return memo[s];
        const result = [];
        for (let i = 0; i < s.length; i++) {
            if (s[i] === '+' || s[i] === '-' || s[i] === '*') {
                const left = helper(s.substring(0, i));
                const right = helper(s.substring(i + 1));
                for (const l of left) {
                    for (const r of right) {
                        if (s[i] === '+') result.push(l + r);
                        else if (s[i] === '-') result.push(l - r);
                        else if (s[i] === '*') result.push(l * r);
                    }
                }
            }
        }
        if (result.length === 0) {
            result.push(parseInt(s));
        }
        memo[s] = result;
        return result;
    }

    return helper(input);
}